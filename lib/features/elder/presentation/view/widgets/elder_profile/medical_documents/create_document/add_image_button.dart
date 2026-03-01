import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class AddImageButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isUploading;

  const AddImageButton({
    super.key,
    required this.onTap,
    required this.isUploading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUploading ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gray[100],
          borderRadius: BorderRadius.circular(context.setMinSize(15)),
          border: Border.all(color: AppColors.gray[500]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(Icons.add_photo_alternate_outlined,size: context.setWidth(30),),
             SizedBox(height: context.setHeight(4)),
            Text('add'.tr(), style: getRegularStyle(color: AppColors.black,fontSize: context.setSp(FontSize.s12))),
          ],
        ),
      ),
    );
  }
}