import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/enums/ai_chat.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/domain/entity/ai_chat/chat_turn_entity.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/ai_chat/ai_message.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/ai_chat/input_bar.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/ai_chat/user_message.dart';

import '../../../../../../core/common_widgets/bg_gradient.dart';
import '../../../../../../core/common_widgets/image_picker.dart';
import '../../../view_model/ai_chat/ai_chat_bloc.dart';
import '../../../view_model/ai_chat/ai_chat_event.dart';
import '../../../view_model/ai_chat/ai_chat_state.dart';

class ConversationDetailsScreen extends StatefulWidget {
  final String userId;
  final String sessionId;
  final String headline;

  const ConversationDetailsScreen({
    super.key,
    required this.userId,
    required this.sessionId,
    required this.headline,
  });

  @override
  State<ConversationDetailsScreen> createState() =>
      _ConversationDetailsScreenState();
}

class _ConversationDetailsScreenState
    extends State<ConversationDetailsScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    _chatBloc = context.read<ChatBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatBloc.add(
        ChatConversationOpened(widget.userId, widget.sessionId),
      );
    });
  }

  @override
  void dispose() {
    _chatBloc.add(ChatConversationClosed());
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    final hasImage = _chatBloc.state.resumedPendingImageBase64 != null;
    if (text.isEmpty && !hasImage) return;
    _chatBloc.add(ResumedMessageSent(text));
    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 50), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _showImageSourceSheet() async {
    await ImagePickerHelper.pickSingleForChat(
      context: context,
      onPicked: (base64, mimeType, displayName) {
        _chatBloc.add(ResumedImagePicked(
          base64: base64,
          mimeType: mimeType,
          displayName: displayName,
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            title: Text(
              widget.headline,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s20),
              ),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: BlocConsumer<ChatBloc, ChatState>(
            buildWhen: (prev, curr) =>
            prev.conversationDetailStatus !=
                curr.conversationDetailStatus ||
                prev.resumedMessages != curr.resumedMessages ||
                prev.isResumedStreaming != curr.isResumedStreaming ||
                prev.resumedPendingImageBase64 !=
                    curr.resumedPendingImageBase64,
            listener: (context, state) {
              if (state.resumedMessages.isNotEmpty) _scrollToBottom();
            },
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(child: _buildBody(context, state)),
                  InputBar(
                    controller: _controller,
                    onSend: state.isResumedStreaming ? null : _sendMessage,
                    onPickImage:
                    state.isResumedStreaming ? null : _showImageSourceSheet,
                    pendingImageBase64: state.resumedPendingImageBase64,
                    onClearImage: () =>
                        _chatBloc.add(ResumedImageCleared()),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, ChatState state) {
    if (state.conversationDetailStatus.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.conversationDetailStatus.isFailure) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 36),
            const SizedBox(height: 8),
            const Text('Failed to load conversation'),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => _chatBloc.add(
                ChatConversationOpened(widget.userId, widget.sessionId),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final detail = state.conversationDetailStatus.data;
    final oldWidgets = _buildOldTurnWidgets(detail?.turns ?? []);
    final newMessages = state.resumedMessages;
    final total = oldWidgets.length + newMessages.length;

    if (total == 0) {
      return const Center(
        child: Text('No messages yet.', style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: total,
      itemBuilder: (context, index) {
        if (index < oldWidgets.length) return oldWidgets[index];

        final msg = newMessages[index - oldWidgets.length];
        return msg.role == ChatMessageRole.user
            ? UserMessage(
          text: msg.text,
          imageBase64: msg.imageBase64,
        )
            : AiMessage(text: msg.text);
      },
    );
  }

  List<Widget> _buildOldTurnWidgets(List<ChatTurnEntity> turns) {
    final widgets = <Widget>[];
    for (final turn in turns) {
      final text = turn.text;
      if (text.trim().isEmpty) continue;
      final isUser = turn.role.toLowerCase() == 'user';
      widgets.add(isUser ? UserMessage(text: text) : AiMessage(text: text));
    }
    return widgets;
  }
}