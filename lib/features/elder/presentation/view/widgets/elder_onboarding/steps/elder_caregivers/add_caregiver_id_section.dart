import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_text_form_field.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_event.dart';

class AddCaregiverIdSection extends StatelessWidget {
  const AddCaregiverIdSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ElderOnboardingBloc>();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: bloc.caregiverIdController,
                hintText: "addCaregiverIdHere".tr(),
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isNotEmpty &&
                      !RegExp(r'^[a-f0-9]{24}$').hasMatch(text)) {
                    return 'invalidId'.tr();
                  }
                  return null;
                },
                hintStyle: getRegularStyle(
                  color: AppColors.gray[800] ?? AppColors.gray,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                final text = bloc.caregiverIdController.text.trim();

                if (text.isEmpty) return;

                if (!RegExp(r'^[a-f0-9]{24}$').hasMatch(text)) {
                  bloc.elderCaregiverFormKey.currentState?.validate();
                  return;
                }

                bloc.add(AddCaregiverIdEvent(text));
                bloc.caregiverIdController.clear();
                bloc.elderCaregiverFormKey.currentState?.validate();
              },
            ),
          ],
        ),

      ],
    );
  }
}
