import 'package:flutter/material.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/ai_chat/user_message.dart';

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

  final List<Map<String, dynamic>> _messages = [];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'text': text, 'isUser': true});
    });

    _controller.clear();

    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);

    // Simulate AI response
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _messages.add({
          'text':
          'I received your message. How else can I assist you today?',
          'isUser': false,
        });
      });
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _messages.isEmpty
              ? _buildEmptyState(context)
              : ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 12),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[index];
              return msg['isUser'] as bool
                  ? UserMessage(text: msg['text'] as String)
                  : AiMessage(text: msg['text'] as String);
            },
          ),
        ),

        InputBar(
          controller: _controller,
          onSend: _sendMessage,
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'How can I help you?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ask me anything. I\'m here for you.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}







