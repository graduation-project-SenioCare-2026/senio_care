import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/custom_dialog.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_style.dart';

class SosBtn extends StatelessWidget {
  const SosBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            title: Image.asset(
              AppIcons.alert,
              width: context.setWidth(40),
              height: context.setHeight(40),
            ),
            content: "emergencyWillSendAfter".tr(),
            confirmText: "send".tr(),
            cancelText: "cancel".tr(),
            onConfirm: () {
              print("SOS Sent!");
            },
            onCancel: () {
              print("SOS cancelled!");
            },
          ),
        );
      },
      child: Container(
        height: context.setHeight(250),
        width: context.setWidth(250),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 5),
          ],
        ),
        child: CircleAvatar(
          backgroundColor: AppColors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppIcons.emergency,
                height: context.setHeight(80),
                width: context.setWidth(80),
              ),
              Text(
                "sos".tr(),
                textAlign: TextAlign.center,
                style: getRegularStyle(
                  color: AppColors.white,
                  fontSize: context.setSp(64),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
