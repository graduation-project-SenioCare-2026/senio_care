import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/enums/ai_chat.dart';
import '../../../../../core/result/result.dart';
import '../../../../../core/state_status/state_status.dart';
import '../../../domain/entity/ai_chat/chat_message_entity.dart';
import '../../../domain/use_case/ai_chat/create_session_use_case.dart';
import '../../../domain/use_case/ai_chat/send_message_use_case.dart';
import 'ai_chat_event.dart';
import 'ai_chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final CreateSessionUseCase _createSessionUseCase;
  final SendMessageUseCase _sendMessageUseCase;

  StreamSubscription<dynamic>? _sseSubscription;

  ChatBloc(
      this._createSessionUseCase,
      this._sendMessageUseCase,
      ) : super(const ChatState()) {
    on<ChatSessionStarted>(_onSessionStarted);
    on<ChatMessageSent>(_onMessageSent);
    on<ChatChunkReceived>(_onChunkReceived);
    on<ChatStreamDone>(_onStreamDone);
    on<ChatStreamFailed>(_onStreamFailed);
  }

  // ── Session Started ──────────────────────────────────────────────────────────

  Future<void> _onSessionStarted(
      ChatSessionStarted event,
      Emitter<ChatState> emit,
      ) async {
    emit(state.copyWith(
      createSessionStatus: const StateStatus.loading(),
    ));

    final result = await _createSessionUseCase(
      userId: event.userId??"",
      sessionId: event.sessionId,
    );

    switch (result) {
      case Success(:final data):
        emit(state.copyWith(
          createSessionStatus: StateStatus.success(data),
        ));
      case Failure(:final responseException):
        emit(state.copyWith(
          createSessionStatus: StateStatus.failure(responseException),
        ));
    }
  }

  // ── Message Sent ─────────────────────────────────────────────────────────────

  Future<void> _onMessageSent(
      ChatMessageSent event,
      Emitter<ChatState> emit,
      ) async {
    if (state.isStreaming) return;
    if (!state.createSessionStatus.isSuccess) return;

    final session = state.createSessionStatus.data!;
    final userMsgId = _generateId();
    final assistantMsgId = _generateId();

    final userMessage = ChatMessageEntity(
      id: userMsgId,
      text: event.message,
      role: ChatMessageRole.user,
      status: ChatMessageStatus.done,
    );

    final assistantMessage = ChatMessageEntity(
      id: assistantMsgId,
      text: '',
      role: ChatMessageRole.assistant,
      status: ChatMessageStatus.streaming,

    );

    emit(state.copyWith(
      messages: [...state.messages, userMessage, assistantMessage],
      isStreaming: true,
    ));

    await _sseSubscription?.cancel();

    _sseSubscription = _sendMessageUseCase(
      userId: session.userId,
      sessionId: session.sessionId,
      message: event.message,
    ).listen(
          (result) => switch (result) {
        Success(:final data) => add(ChatChunkReceived(
         data,
           assistantMsgId,
        )),
        Failure(:final responseException) => add(ChatStreamFailed(
           responseException.message,
          assistantMsgId,
        )),
      },
      onDone: () => add(ChatStreamDone( assistantMsgId)),
      onError: (e) => add(ChatStreamFailed(
         e.toString(),
         assistantMsgId,
      )),
    );
  }

  // ── Chunk Received ────────────────────────────────────────────────────────────

  void _onChunkReceived(
      ChatChunkReceived event,
      Emitter<ChatState> emit,
      ) {
    final updated = state.messages.map((msg) {
      if (msg.id == event.assistantMessageId) {
        return msg.copyWith(text: msg.text + event.chunk);
      }
      return msg;
    }).toList();

    emit(state.copyWith(messages: updated));
  }

  // ── Stream Done ────────────────────────────────────────────────────────────────

  void _onStreamDone(
      ChatStreamDone event,
      Emitter<ChatState> emit,
      ) {
    final updated = state.messages.map((msg) {
      if (msg.id == event.assistantMessageId) {
        return msg.copyWith(status: ChatMessageStatus.done);
      }
      return msg;
    }).toList();

    emit(state.copyWith(messages: updated, isStreaming: false));
  }

  // ── Stream Failed ──────────────────────────────────────────────────────────────

  void _onStreamFailed(
      ChatStreamFailed event,
      Emitter<ChatState> emit,
      ) {
    final updated = state.messages.map((msg) {
      if (msg.id == event.assistantMessageId) {
        return msg.copyWith(
          text: msg.text.isEmpty ? 'Something went wrong.' : msg.text,
          status: ChatMessageStatus.error,
        );
      }
      return msg;
    }).toList();

    emit(state.copyWith(messages: updated, isStreaming: false));
  }

  @override
  Future<void> close() {
    _sseSubscription?.cancel();
    return super.close();
  }

  String _generateId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rnd = Random();
    return List.generate(16, (_) => chars[rnd.nextInt(chars.length)]).join();
  }
}
