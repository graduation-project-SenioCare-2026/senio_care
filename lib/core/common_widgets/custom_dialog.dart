import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class CustomDialog extends StatelessWidget {
  final Widget title;
  final String? content;
  final Widget? afterContent;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const CustomDialog({
    super.key,
    required this.title,
     this.content,
    this.afterContent,
    this.confirmText = "OK",
    this.cancelText = "Cancel",
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,

      title: title,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(content!=null)
          Text(
            content!,
            style: getBoldStyle(
              color: AppColors.black,
              fontSize: context.setSp(FontSize.s14),
            ),
          ),
          if (afterContent != null) afterContent!,
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  side: BorderSide(
                    color: AppColors.blue,
                    width: context.setWidth(2),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.setWidth(20)),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.setWidth(25),
                    vertical: context.setHeight(16),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onCancel?.call();
                },
                child: Text(
                  cancelText,
                  style: getRegularStyle(
                    color: AppColors.black,
                    fontSize: context.setSp(FontSize.s14),
                  ),
                ),
              ),
            ),

            SizedBox(width: context.setWidth(20)),
            SizedBox(
              width: context.setWidth(100),
              child: CustomElevatedButton(
                titleStyle: getRegularStyle(
                  color: AppColors.white,
                  fontSize: context.setSp(FontSize.s14),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm?.call();
                },
                buttonLabel: confirmText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
