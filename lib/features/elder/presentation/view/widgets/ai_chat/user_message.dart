import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';

import '../../../../../../core/theme/font_manager.dart';
import '../../../../../../core/theme/font_style.dart';

class UserMessage extends StatelessWidget {
  final String text;
  final String? imageBase64;

  const UserMessage({super.key, required this.text, this.imageBase64});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
          bottom: context.setHeight(12),
          left: context.setWidth(60),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.setWidth(16),
          vertical: context.setHeight(12),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.blue.shade300, AppColors.blue.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imageBase64 != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.memory(
                  base64Decode(imageBase64!),
                  width: context.setWidth(180),
                  fit: BoxFit.cover,
                ),
              ),
              if (text.isNotEmpty) SizedBox(height: context.setHeight(8)),
            ],

            if (text.isNotEmpty)
              Text(
                text,
                style: getRegularStyle(
                  color: AppColors.white,
                  fontSize: context.setSp(FontSize.s18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}