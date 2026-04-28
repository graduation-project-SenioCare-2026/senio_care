import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:senio_care/features/elder/presentation/view/widgets/ai_chat/user_message.dart';

import '../../../../../../core/common_widgets/image_picker.dart';
import '../../../../../../core/enums/ai_chat.dart';
import '../../../view_model/ai_chat/ai_chat_bloc.dart';
import '../../../view_model/ai_chat/ai_chat_event.dart';
import '../../../view_model/ai_chat/ai_chat_state.dart';
import 'ai_message.dart';
import 'input_bar.dart';

class AiChatBody extends StatefulWidget {
  const AiChatBody({super.key});

  @override
  State<AiChatBody> createState() => _AiChatBodyState();
}

class _AiChatBodyState extends State<AiChatBody> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final text = _controller.text.trim();
    final hasImage =
        context.read<ChatBloc>().state.pendingImageBase64 != null;
    // Allow sending with image only, or text only, or both
    if (text.isEmpty && !hasImage) return;

    context.read<ChatBloc>().add(ChatMessageSent(text));
    _controller.clear();
    _scrollToBottom();
  }

  Future<void> _showImageSourceSheet() async {
    final bloc = context.read<ChatBloc>();
    await ImagePickerHelper.pickSingleForChat(
      context: context,
      onPicked: (base64, mimeType, displayName) {
        bloc.add(ChatImagePicked(
          base64: base64,
          mimeType: mimeType,
          displayName: displayName,
        ));
      },
    );
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

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state.messages.isNotEmpty) _scrollToBottom();
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: state.messages.isEmpty
                  ? _buildEmptyState(context, state)
                  : ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  final msg = state.messages[index];
                  return msg.role == ChatMessageRole.user
                      ? UserMessage(
                    text: msg.text,
                    imageBase64: msg.imageBase64,
                  )
                      : AiMessage(text: msg.text);
                },
              ),
            ),
            InputBar(
              controller: _controller,
              onSend: state.isStreaming ? null : _sendMessage,
              onPickImage:
              state.isStreaming ? null : _showImageSourceSheet,
              pendingImageBase64: state.pendingImageBase64,
              onClearImage: () =>
                  context.read<ChatBloc>().add(ChatImageCleared()),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, ChatState state) {
    if (state.createSessionStatus.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.createSessionStatus.isFailure) {
      return const Center(
        child: Text('Failed to start session. Please try again.'),
      );
    }
    return const Center(child: Text('How can I help you?'));
  }
}