import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/common_widgets/custom_dialog.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/view_model/sos/sos_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/sos/sos_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/sos/sos_state.dart';

class SosBtn extends StatelessWidget {
  final String emergencyNumber;

  const SosBtn({super.key, required this.emergencyNumber});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SosBloc, SosState>(
      builder: (context, state) {
        final bloc = context.read<SosBloc>();

        return InkWell(
          onTap: () {
            _showConfirmationDialog(context, bloc);
          },
          child: Container(
            height: context.setHeight(250),
            width: context.setWidth(250),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
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
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, SosBloc bloc) {
    int seconds = 5;
    Timer? timer;
    bool actionExecuted = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            timer ??= Timer.periodic(const Duration(seconds: 1), (t) {
              if (seconds > 1) {
                setState(() {
                  seconds--;
                });
              } else {
                if (!actionExecuted) {
                  actionExecuted = true;
                  timer?.cancel();
                  Navigator.of(dialogContext).pop();
                  bloc.add(CallNumberEvent(emergencyNumber));
                }
              }
            });

            return CustomDialog(
              title: Image.asset(
                AppIcons.alert,
                width: context.setWidth(40),
                height: context.setHeight(40),
              ),
              content: "${"emergencyWillSendAfter".tr()} $seconds",
              confirmText: "send".tr(),
              cancelText: "cancel".tr(),
              onConfirm: () {
                if (!actionExecuted) {
                  actionExecuted = true;
                  timer?.cancel();
                  bloc.add(CallNumberEvent(emergencyNumber));
                }
              },
              onCancel: () {
                actionExecuted = true;
                timer?.cancel();
              },
            );
          },
        );
      },
    ).then((_) {
      timer?.cancel();
    });
  }
}
