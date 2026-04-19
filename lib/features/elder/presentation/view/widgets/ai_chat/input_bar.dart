import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';

import '../../../../../../core/theme/font_manager.dart';
import '../../../../../../core/theme/font_style.dart';

class InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSend; // ✅ nullable — null = disabled

  const InputBar({super.key, required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    final bool canSend = onSend != null;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.send,
                onSubmitted: canSend ? (_) => onSend!() : null,
                enabled: canSend, // ✅ disables typing while streaming
                maxLines: 4,
                minLines: 1,
                style: getRegularStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s16),
                ),
                decoration: InputDecoration(
                  hintText: canSend ? 'Type your message...' : 'Waiting for response...',
                  hintStyle: const TextStyle(color: Colors.black38),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: context.setWidth(18),
                    vertical: context.setHeight(12),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: context.setWidth(10)),
          GestureDetector(
            onTap: onSend, // ✅ null = no-op tap
            child: AnimatedOpacity(
              opacity: canSend ? 1.0 : 0.4, // ✅ visual feedback
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: context.setWidth(46),
                height: context.setHeight(46),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.blue.shade300, AppColors.blue.shade500],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}