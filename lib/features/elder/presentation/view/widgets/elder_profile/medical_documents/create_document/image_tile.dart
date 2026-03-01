import 'dart:io';

import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class ImageTile extends StatelessWidget {
  final File file;
  final int index;
  final double progress;
  final bool isUploading;
  final VoidCallback? onRemove;
  final VoidCallback onTap;

  const ImageTile({
    super.key,
    required this.file,
    required this.index,
    required this.progress,
    required this.isUploading,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.all(
                Radius.circular(context.setMinSize(10)),
              ),
              border: BoxBorder.all(color: AppColors.gray),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.setMinSize(10)),
              child: Image.file(file, fit: BoxFit.contain, cacheWidth: 1200),
            ),
          ),

          // ── Upload Overlay ────────────────────────────────
          if (isUploading)
            ClipRRect(
              borderRadius: BorderRadius.circular(context.setMinSize(10)),
              child: Container(
                color: AppColors.black.withAlpha(55),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: context.setWidth(35),
                        height: context.setWidth(35),
                        child: CircularProgressIndicator(
                          value: progress > 0 ? progress : null,
                          color: AppColors.green,
                          strokeWidth: context.setWidth(3),
                          backgroundColor: AppColors.white,
                        ),
                      ),
                      SizedBox(height: context.setHeight(5)),
                      Text(
                        progress > 0
                            ? '${(progress * 100).toStringAsFixed(0)}%'
                            : '...',
                        style: getBoldStyle(
                          color: AppColors.white,
                          fontSize: context.setSp(FontSize.s12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // ── Done Badge → top-LEFT ─────────────────────────
          if (!isUploading && progress >= 1.0)
            Positioned(
              top: 4,
              left: 4,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 12),
              ),
            ),

          // ── Remove Button → top-RIGHT ─────────────────────
          if (!isUploading && onRemove != null)
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 14),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
