import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';

import '../../../../../../core/theme/font_manager.dart';
import '../../../../../../core/theme/font_style.dart';

class InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSend;
  final VoidCallback? onPickImage;
  final String? pendingImageBase64;
  final VoidCallback? onClearImage;

  const InputBar({
    super.key,
    required this.controller,
    required this.onSend,
    this.onPickImage,
    this.pendingImageBase64,
    this.onClearImage,
  });

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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: canSend ? onPickImage : null,
            child: AnimatedOpacity(
              opacity: canSend ? 1.0 : 0.4,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: context.setWidth(40),
                height: context.setHeight(40),
                margin: EdgeInsets.only(
                  right: context.setWidth(8),
                  bottom: context.setHeight(3),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Icon(
                  Icons.add_rounded,
                  size: 22,
                  color: canSend
                      ? AppColors.blue.shade500
                      : Colors.grey.shade400,
                ),
              ),
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (pendingImageBase64 != null) ...[
                    Padding(
                      padding: EdgeInsets.only(
                        left: context.setWidth(12),
                        right: context.setWidth(12),
                        top: context.setHeight(10),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              base64Decode(pendingImageBase64!),
                              width: context.setWidth(64),
                              height: context.setHeight(64),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: -6,
                            right: -6,
                            child: GestureDetector(
                              onTap: onClearImage,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close_rounded,
                                  size: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  TextField(
                    controller: controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: canSend ? (_) => onSend!() : null,
                    enabled: canSend,
                    maxLines: 4,
                    minLines: 1,
                    style: getRegularStyle(
                      color: AppColors.black,
                      fontSize: context.setSp(FontSize.s16),
                    ),
                    decoration: InputDecoration(
                      hintText: canSend
                          ? 'Type your message...'
                          : 'Waiting for response...',
                      hintStyle: const TextStyle(color: Colors.black38),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.setWidth(18),
                        vertical: context.setHeight(12),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: context.setWidth(10)),

          GestureDetector(
            onTap: onSend,
            child: AnimatedOpacity(
              opacity: canSend ? 1.0 : 0.4,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: context.setWidth(46),
                height: context.setHeight(46),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.blue.shade300,
                      AppColors.blue.shade500,
                    ],
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