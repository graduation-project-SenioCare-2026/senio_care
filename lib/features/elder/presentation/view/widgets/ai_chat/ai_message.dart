import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/font_style.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/font_manager.dart';

class AiMessage extends StatelessWidget {
  final String text;
  const AiMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: context.setHeight(16),
          right: context.setWidth(60),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: context.setHeight(2),
                right: context.setWidth(10),
              ),
              width: context.setWidth(32),
              height: context.setHeight(32),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.blue.shade300, AppColors.blue.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(
                Icons.support_agent_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
            Flexible(
              child: text.isEmpty
                  ? _buildTypingIndicator()
                  : Text(
                text,
                style: getRegularStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      children: [
        _dot(),
        _dot(),
        _dot(),
      ],
    );
  }

  Widget _dot() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 2),
    width: 7,
    height: 7,
    decoration: const BoxDecoration(
      color: Colors.grey,
      shape: BoxShape.circle,
    ),
  );
}