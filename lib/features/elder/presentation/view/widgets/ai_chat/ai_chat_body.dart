import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/ai_chat/user_message.dart';

import '../../../../../../core/theme/font_style.dart';
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
          'text': 'I received your message. How else can I assist you today?',
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
                  padding: EdgeInsets.symmetric(
                    horizontal: context.setWidth(16),
                    vertical: context.setHeight(12),
                  ),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return msg['isUser'] as bool
                        ? UserMessage(text: msg['text'] as String)
                        : AiMessage(text: msg['text'] as String);
                  },
                ),
        ),

        InputBar(controller: _controller, onSend: _sendMessage),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'howCanIHelpYou?'.tr(),
            style: getBoldStyle(
              fontSize: context.setSp(FontSize.s22),
              color: AppColors.black,
            ),
          ),
          SizedBox(height: context.setHeight(8)),
          Text(
            "askMeAnything.I'mHereForYou.".tr(),
            style: getRegularStyle(
              color: AppColors.black,
              fontSize: context.setSp(FontSize.s14),
            ),
          ),
        ],
      ),
    );
  }
}
