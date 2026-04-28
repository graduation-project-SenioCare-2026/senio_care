import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/features/elder/domain/entity/ai_chat/chat_session_entity.dart';
import 'package:senio_care/features/elder/domain/entity/ai_chat/chat_turn_entity.dart';

import '../../../../../core/enums/ai_chat.dart';
import '../../../../../core/result/result.dart';
import '../../../../../core/state_status/state_status.dart';
import '../../../domain/entity/ai_chat/chat_message_entity.dart';
import '../../../domain/entity/ai_chat/session_entity.dart';
import '../../../domain/use_case/ai_chat/create_session_use_case.dart';
import '../../../domain/use_case/ai_chat/get_chat_history_use_case.dart';
import '../../../domain/use_case/ai_chat/get_conversation_use_case.dart';
import '../../../domain/use_case/ai_chat/send_message_use_case.dart';
import 'ai_chat_event.dart';
import 'ai_chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final CreateSessionUseCase _createSessionUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final GetChatHistoryUseCase _getChatHistoryUseCase;
  final GetConversationTurnsUseCase _getConversationTurnsUseCase;

  StreamSubscription<dynamic>? _mainSseSubscription;
  StreamSubscription<dynamic>? _resumedSseSubscription;

  // Debounce state for main session
  Timer? _mainChunkDebounce;
  String _mainPendingChunk = '';
  String? _mainPendingTargetId;

  // Debounce state for resumed session
  Timer? _resumedChunkDebounce;
  String _resumedPendingChunk = '';
  String? _resumedPendingTargetId;

  ChatBloc(
      this._createSessionUseCase,
      this._sendMessageUseCase,
      this._getChatHistoryUseCase,
      this._getConversationTurnsUseCase,
      ) : super(const ChatState()) {
    on<ChatSessionStarted>(_onSessionStarted);
    on<ChatMessageSent>(_onMessageSent);
    on<ChatChunkReceived>(_onChunkReceived);
    on<ChatChunkFlushed>(_onChunkFlushed);
    on<ChatStreamDone>(_onStreamDone);
    on<ChatStreamFailed>(_onStreamFailed);
    on<ChatHistoryRequested>(_onHistoryRequested);
    on<ChatConversationOpened>(_onConversationOpened);
    on<ResumedMessageSent>(_onResumedMessageSent);
    on<ResumedChunkReceived>(_onResumedChunkReceived);
    on<ResumedChunkFlushed>(_onResumedChunkFlushed);
    on<ResumedStreamDone>(_onResumedStreamDone);
    on<ResumedStreamFailed>(_onResumedStreamFailed);
    on<ChatConversationClosed>(_onConversationClosed);
    on<ChatImagePicked>(_onImagePicked);
    on<ChatImageCleared>(_onImageCleared);
    on<ResumedImagePicked>(_onResumedImagePicked);
    on<ResumedImageCleared>(_onResumedImageCleared);
  }

  // ── Main session ─────────────────────────────────────────────────────────────

  Future<void> _onSessionStarted(
      ChatSessionStarted event,
      Emitter<ChatState> emit,
      ) async {
    emit(state.copyWith(createSessionStatus: const StateStatus.loading()));

    final result = await _createSessionUseCase(
      userId: event.userId ?? '',
      sessionId: event.sessionId,
    );

    switch (result) {
      case Success(:final data):
        emit(state.copyWith(createSessionStatus: StateStatus.success(data)));
      case Failure(:final responseException):
        emit(state.copyWith(
            createSessionStatus: StateStatus.failure(responseException)));
    }
  }

  Future<void> _onMessageSent(
      ChatMessageSent event,
      Emitter<ChatState> emit,
      ) async {
    if (state.isStreaming) return;
    if (!state.createSessionStatus.isSuccess) return;

    await _mainSseSubscription?.cancel();
    _mainSseSubscription = null;

    final session = state.createSessionStatus.data!;
    final userMsgId = _generateId();
    final assistantMsgId = _generateId();

    // Prefer event-level image (direct call), fall back to state pending image
    final imageBase64 = event.imageBase64 ?? state.pendingImageBase64;
    final imageMimeType = event.imageMimeType ?? state.pendingImageMimeType;
    final imageDisplayName =
        event.imageDisplayName ?? state.pendingImageDisplayName;

    emit(
      state.copyWith(
        messages: [
          ...state.messages,
          ChatMessageEntity(
            id: userMsgId,
            text: event.message,
            imageBase64: imageBase64,
            role: ChatMessageRole.user,
            status: ChatMessageStatus.done,
          ),
          ChatMessageEntity(
            id: assistantMsgId,
            text: '',
            role: ChatMessageRole.assistant,
            status: ChatMessageStatus.streaming,
          ),
        ],
        isStreaming: true,
        // Clear pending image after sending
        pendingImageBase64: null,
        pendingImageMimeType: null,
        pendingImageDisplayName: null,
      ),
    );

    final targetId = assistantMsgId;

    _mainSseSubscription = _sendMessageUseCase(
      userId: session.userId,
      sessionId: session.sessionId,
      message: event.message,
      imageBase64: imageBase64,
      imageMimeType: imageMimeType,
      imageDisplayName: imageDisplayName,
    ).listen(
          (result) => switch (result) {
        Success(:final data) => add(ChatChunkReceived(data, targetId)),
        Failure(:final responseException) =>
            add(ChatStreamFailed(responseException.message, targetId)),
      },
      onDone: () => add(ChatStreamDone(targetId)),
      onError: (e) => add(ChatStreamFailed(e.toString(), targetId)),
    );
  }

  // Accumulate chunks and debounce UI updates (50ms batching)
  void _onChunkReceived(ChatChunkReceived event, Emitter<ChatState> emit) {
    _mainPendingChunk += event.chunk;
    _mainPendingTargetId = event.assistantMessageId;

    _mainChunkDebounce?.cancel();
    _mainChunkDebounce = Timer(const Duration(milliseconds: 50), () {
      final chunk = _mainPendingChunk;
      final targetId = _mainPendingTargetId;
      _mainPendingChunk = '';
      _mainPendingTargetId = null;
      if (targetId != null && chunk.isNotEmpty) {
        add(ChatChunkFlushed(chunk, targetId));
      }
    });
  }

  // Actually updates state with batched chunk
  void _onChunkFlushed(ChatChunkFlushed event, Emitter<ChatState> emit) {
    final updated = state.messages.map((msg) {
      if (msg.id != event.assistantMessageId) return msg;
      final newText = msg.text + event.chunk;
      if (newText == msg.text) return msg;
      return msg.copyWith(text: newText);
    }).toList();
    emit(state.copyWith(messages: updated));
  }

  void _onStreamDone(ChatStreamDone event, Emitter<ChatState> emit) {
    _mainChunkDebounce?.cancel();

    // Build the final messages list in one shot
    var messages = state.messages;

    // Flush pending chunk inline BEFORE emitting done
    if (_mainPendingChunk.isNotEmpty && _mainPendingTargetId != null) {
      final pendingChunk = _mainPendingChunk;
      final pendingId = _mainPendingTargetId!;
      messages = messages.map((msg) {
        if (msg.id != pendingId) return msg;
        return msg.copyWith(text: msg.text + pendingChunk);
      }).toList();
      _mainPendingChunk = '';
      _mainPendingTargetId = null;
    }

    // Now mark as done — single emit with full final text
    final updated = messages.map((msg) {
      if (msg.id != event.assistantMessageId) return msg;
      return msg.copyWith(status: ChatMessageStatus.done);
    }).toList();

    emit(state.copyWith(messages: updated, isStreaming: false));
  }
  void _onStreamFailed(ChatStreamFailed event, Emitter<ChatState> emit) {
    _mainChunkDebounce?.cancel();
    _mainPendingChunk = '';
    _mainPendingTargetId = null;

    final updated = state.messages.map((msg) {
      if (msg.id != event.assistantMessageId) return msg;
      return msg.copyWith(
        text: msg.text.isEmpty ? 'Something went wrong.' : msg.text,
        status: ChatMessageStatus.error,
      );
    }).toList();
    emit(state.copyWith(messages: updated, isStreaming: false));
  }

  // ── History ──────────────────────────────────────────────────────────────────

  Future<void> _onHistoryRequested(
      ChatHistoryRequested event,
      Emitter<ChatState> emit,
      ) async {
    debugPrint('📋 [History] Requesting history for userId: ${event.userId}');
    emit(state.copyWith(historyStatus: const StateStatus.loading()));

    final result = await _getChatHistoryUseCase(userId: event.userId);

    switch (result) {
      case Success<List<ChatSessionEntity>>():
        debugPrint(
            '✅ [History] Success — ${result.data.length} sessions loaded');
        emit(state.copyWith(historyStatus: StateStatus.success(result.data)));
      case Failure<List<ChatSessionEntity>>():
        debugPrint('❌ [History] Failed — ${result.responseException.message}');
        emit(state.copyWith(
            historyStatus: StateStatus.failure(result.responseException)));
    }
  }

  // ── Resumed session ──────────────────────────────────────────────────────────

  Future<void> _onConversationOpened(
      ChatConversationOpened event,
      Emitter<ChatState> emit,
      ) async {
    await _resumedSseSubscription?.cancel();
    _resumedSseSubscription = null;

    final resumedSession = SessionEntity(
      sessionId: event.sessionId,
      appName: state.createSessionStatus.data?.appName ?? '',
      userId: event.userId,
    );

    emit(
      state.copyWith(
        conversationDetailStatus: const StateStatus.loading(),
        resumedSession: resumedSession,
        resumedMessages: [],
        isResumedStreaming: false,
      ),
    );

    final result = await _getConversationTurnsUseCase(
      userId: event.userId,
      sessionId: event.sessionId,
    );

    switch (result) {
      case Success<ConversationDetailEntity>():
        emit(state.copyWith(
            conversationDetailStatus: StateStatus.success(result.data)));
      case Failure<ConversationDetailEntity>():
        emit(state.copyWith(
            conversationDetailStatus:
            StateStatus.failure(result.responseException)));
    }
  }

  Future<void> _onResumedMessageSent(
      ResumedMessageSent event,
      Emitter<ChatState> emit,
      ) async {
    if (state.isResumedStreaming) return;
    if (state.resumedSession == null) return;

    await _resumedSseSubscription?.cancel();
    _resumedSseSubscription = null;

    final session = state.resumedSession!;
    final userMsgId = _generateId();
    final assistantMsgId = _generateId();

    // ✅ FIX: Prefer event-level image, fall back to state pending image
    final imageBase64 = event.imageBase64 ?? state.resumedPendingImageBase64;
    final imageMimeType =
        event.imageMimeType ?? state.resumedPendingImageMimeType;
    final imageDisplayName =
        event.imageDisplayName ?? state.resumedPendingImageDisplayName;

    emit(
      state.copyWith(
        resumedMessages: [
          ...state.resumedMessages,
          ChatMessageEntity(
            id: userMsgId,
            text: event.message,
            imageBase64: imageBase64, // ✅ FIX: attach image to user message
            role: ChatMessageRole.user,
            status: ChatMessageStatus.done,
          ),
          ChatMessageEntity(
            id: assistantMsgId,
            text: '',
            role: ChatMessageRole.assistant,
            status: ChatMessageStatus.streaming,
          ),
        ],
        isResumedStreaming: true,
        // ✅ FIX: clear pending image after sending
        resumedPendingImageBase64: null,
        resumedPendingImageMimeType: null,
        resumedPendingImageDisplayName: null,
      ),
    );

    final targetId = assistantMsgId;

    // ✅ FIX: pass image params to the use case
    _resumedSseSubscription = _sendMessageUseCase(
      userId: session.userId,
      sessionId: session.sessionId,
      message: event.message,
      imageBase64: imageBase64,
      imageMimeType: imageMimeType,
      imageDisplayName: imageDisplayName,
    ).listen(
          (result) => switch (result) {
        Success(:final data) => add(ResumedChunkReceived(data, targetId)),
        Failure(:final responseException) =>
            add(ResumedStreamFailed(responseException.message, targetId)),
      },
      onDone: () => add(ResumedStreamDone(targetId)),
      onError: (e) => add(ResumedStreamFailed(e.toString(), targetId)),
    );
  }

  // Accumulate resumed chunks and debounce
  void _onResumedChunkReceived(
      ResumedChunkReceived event,
      Emitter<ChatState> emit,
      ) {
    _resumedPendingChunk += event.chunk;
    _resumedPendingTargetId = event.assistantMessageId;

    _resumedChunkDebounce?.cancel();
    _resumedChunkDebounce = Timer(const Duration(milliseconds: 50), () {
      final chunk = _resumedPendingChunk;
      final targetId = _resumedPendingTargetId;
      _resumedPendingChunk = '';
      _resumedPendingTargetId = null;
      if (targetId != null && chunk.isNotEmpty) {
        add(ResumedChunkFlushed(chunk, targetId));
      }
    });
  }

  // Actually updates resumed state with batched chunk
  void _onResumedChunkFlushed(
      ResumedChunkFlushed event,
      Emitter<ChatState> emit,
      ) {
    final updated = state.resumedMessages.map((msg) {
      if (msg.id != event.assistantMessageId) return msg;
      final newText = msg.text + event.chunk;
      if (newText == msg.text) return msg;
      return msg.copyWith(text: newText);
    }).toList();
    emit(state.copyWith(resumedMessages: updated));
  }

  void _onResumedStreamDone(
      ResumedStreamDone event,
      Emitter<ChatState> emit,
      ) {
    _resumedChunkDebounce?.cancel();

    // Flush pending chunk inline BEFORE emitting done
    var messages = state.resumedMessages;

    if (_resumedPendingChunk.isNotEmpty && _resumedPendingTargetId != null) {
      final pendingChunk = _resumedPendingChunk;
      final pendingId = _resumedPendingTargetId!;
      messages = messages.map((msg) {
        if (msg.id != pendingId) return msg;
        return msg.copyWith(text: msg.text + pendingChunk);
      }).toList();
      _resumedPendingChunk = '';
      _resumedPendingTargetId = null;
    }

    // Mark as done — single emit with full final text
    final updated = messages.map((msg) {
      if (msg.id != event.assistantMessageId) return msg;
      return msg.copyWith(status: ChatMessageStatus.done);
    }).toList();

    emit(state.copyWith(resumedMessages: updated, isResumedStreaming: false));
  }

  void _onResumedStreamFailed(
      ResumedStreamFailed event,
      Emitter<ChatState> emit,
      ) {
    _resumedChunkDebounce?.cancel();
    _resumedPendingChunk = '';
    _resumedPendingTargetId = null;

    final updated = state.resumedMessages.map((msg) {
      if (msg.id != event.assistantMessageId) return msg;
      return msg.copyWith(
        text: msg.text.isEmpty ? 'Something went wrong.' : msg.text,
        status: ChatMessageStatus.error,
      );
    }).toList();
    emit(state.copyWith(resumedMessages: updated, isResumedStreaming: false));
  }

  void _onConversationClosed(
      ChatConversationClosed event,
      Emitter<ChatState> emit,
      ) {
    _resumedSseSubscription?.cancel();
    _resumedSseSubscription = null;
    emit(
      state.copyWith(
        conversationDetailStatus: const StateStatus.initial(),
        resumedSession: null,
        resumedMessages: [],
        isResumedStreaming: false,
      ),
    );
  }

  void _onImagePicked(ChatImagePicked event, Emitter<ChatState> emit) {
    emit(state.copyWith(
      pendingImageBase64: event.base64,
      pendingImageMimeType: event.mimeType,
      pendingImageDisplayName: event.displayName,
    ));
  }

  void _onResumedImagePicked(
      ResumedImagePicked event, Emitter<ChatState> emit) {
    emit(state.copyWith(
      resumedPendingImageBase64: event.base64,
      resumedPendingImageMimeType: event.mimeType,
      resumedPendingImageDisplayName: event.displayName,
    ));
  }

  void _onImageCleared(ChatImageCleared event, Emitter<ChatState> emit) {
    emit(state.copyWith(
      pendingImageBase64: null,
      pendingImageMimeType: null,
      pendingImageDisplayName: null,
    ));
  }

  void _onResumedImageCleared(
      ResumedImageCleared event,
      Emitter<ChatState> emit,
      ) {
    emit(state.copyWith(
      resumedPendingImageBase64: null,
      resumedPendingImageMimeType: null,
      resumedPendingImageDisplayName: null,
    ));
  }

  @override
  Future<void> close() {
    _mainChunkDebounce?.cancel();
    _resumedChunkDebounce?.cancel();
    _mainSseSubscription?.cancel();
    _resumedSseSubscription?.cancel();
    return super.close();
  }

  String _generateId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rnd = Random();
    return List.generate(16, (_) => chars[rnd.nextInt(chars.length)]).join();
  }
}