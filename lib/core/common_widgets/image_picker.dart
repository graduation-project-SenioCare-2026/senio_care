import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class ImagePickerHelper {
  static Future<List<File>> pickImages(BuildContext context) async {
    final picker = ImagePicker();
    List<File> selected = [];

    final result = await showModalBottomSheet<List<File>>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.photo_library,
                size: context.setMinSize(30),
                color: AppColors.gradientEnd,
              ),
              title: Text(
                'pickFromGallery'.tr(),
                style: getRegularStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s16),
                ),
              ),
              onTap: () async {
                final picked = await picker.pickMultiImage(
                  imageQuality: 75,
                  maxWidth: 1080,
                );

                if (picked.isNotEmpty) {
                  final files = picked.map((e) => File(e.path)).toList();

                  if (context.mounted) {
                    Navigator.of(context).pop(files);
                  }
                }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.camera_alt,
                size: context.setMinSize(30),
                color: AppColors.gradientEnd,
              ),
              title: Text(
                'captureFromCamera'.tr(),
                style: getRegularStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s16),
                ),
              ),
              onTap: () async {
                final localContext = context;
                List<File> files = [];
                bool more = true;

                while (more) {
                  final image = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 75,
                    maxWidth: 1080,
                  );

                  if (image != null) {
                    files.add(File(image.path));

                    if (!localContext.mounted) break;

                    more = await showDialog<bool>(
                      context: localContext,
                      builder: (_) => AlertDialog(
                        backgroundColor: AppColors.white,
                        title: Text(
                          'captureAnother'.tr(),
                          style: getRegularStyle(
                            color: AppColors.black,
                            fontSize: localContext.setSp(FontSize.s16),
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: AppColors.white,
                                  side: BorderSide(
                                    color: AppColors.blue,
                                    width: localContext.setWidth(2),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      localContext.setWidth(20),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: localContext.setWidth(25),
                                    vertical: localContext.setHeight(16),
                                  ),
                                ),
                                onPressed: () =>
                                    Navigator.of(localContext).pop(false),
                                child: Text(
                                  'no'.tr(),
                                  style: getRegularStyle(
                                    color: AppColors.black,
                                    fontSize:
                                    localContext.setSp(FontSize.s14),
                                  ),
                                ),
                              ),
                              SizedBox(width: localContext.setWidth(20)),
                              SizedBox(
                                width: localContext.setWidth(100),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        localContext.setWidth(20),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: localContext.setWidth(25),
                                      vertical: localContext.setHeight(16),
                                    ),
                                  ),
                                  onPressed: () =>
                                      Navigator.of(localContext).pop(true),
                                  child: Text(
                                    'yes'.tr(),
                                    style: getRegularStyle(
                                      color: AppColors.white,
                                      fontSize:
                                      localContext.setSp(FontSize.s14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ) ??
                        false;
                  } else {
                    more = false;
                  }
                }

                if (localContext.mounted) {
                  Navigator.pop(localContext, files);
                }
              },
            ),
          ],
        ),
      ),
    );

    if (result != null) selected.addAll(result);
    return selected;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // New method – used by AiChatBody
  // Picks a single image (gallery or camera), converts it to base64, and
  // returns the result via [onPicked] callback so the caller's BLoC can
  // dispatch ChatImagePicked without touching file I/O itself.
  // ─────────────────────────────────────────────────────────────────────────
  static Future<void> pickSingleForChat({
    required BuildContext context,
    required void Function(
        String base64,
        String mimeType,
        String displayName,
        ) onPicked,
  }) async {
    final picker = ImagePicker();

    await showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.photo_library,
                size: context.setMinSize(30),
                color: AppColors.gradientEnd,
              ),
              title: Text(
                'pickFromGallery'.tr(),
                style: getRegularStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s16),
                ),
              ),
              onTap: () async {
                Navigator.of(sheetContext).pop();

                final picked = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 75,
                  maxWidth: 1080,
                );

                if (picked != null) {
                  final bytes = await File(picked.path).readAsBytes();
                  onPicked(
                    base64Encode(bytes),
                    _mimeFromPath(picked.path),
                    picked.name,
                  );
                }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.camera_alt,
                size: context.setMinSize(30),
                color: AppColors.gradientEnd,
              ),
              title: Text(
                'captureFromCamera'.tr(),
                style: getRegularStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s16),
                ),
              ),
              onTap: () async {
                Navigator.of(sheetContext).pop();

                final picked = await picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 75,
                  maxWidth: 1080,
                );

                if (picked != null) {
                  final bytes = await File(picked.path).readAsBytes();
                  onPicked(
                    base64Encode(bytes),
                    _mimeFromPath(picked.path),
                    picked.name,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Private helper – resolves MIME type from file extension.
  static String _mimeFromPath(String path) {
    final ext = path.split('.').last.toLowerCase();
    switch (ext) {
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'heic':
      case 'heif':
        return 'image/heic';
      default:
        return 'image/jpeg';
    }
  }
}