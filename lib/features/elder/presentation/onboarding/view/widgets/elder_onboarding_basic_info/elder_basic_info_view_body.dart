import 'package:easy_localization/easy_localization.dart' as elderBasicTitle;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/blur_container.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/common_widgets/custom_text_form_field.dart';
import 'package:senio_care/core/common_widgets/header_text.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/validator/validator.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding_basic_info/caregivers_section.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_event.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_state.dart';

class ElderBasicInfoViewBody extends StatefulWidget {
  const ElderBasicInfoViewBody({super.key});

  @override
  State<ElderBasicInfoViewBody> createState() => _ElderBasicInfoViewBodyState();
}

class _ElderBasicInfoViewBodyState extends State<ElderBasicInfoViewBody> {
  String? selectedGender;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElderOnboardingBloc, ElderOnboardingState>(
      builder:(context, state) {
        final bloc=context.read<ElderOnboardingBloc>();
        return Form(
          key: bloc.formKey,
          child: Column(
            children: [
              SizedBox(height: context.setHeight(50)),
              HeaderText(
                title: "elderOnboardingBasicTitle".tr(),
                titleSize: FontSize.s30,
                subTitle: "elderOnboardingBasicSubtitle".tr(),
                subTitleSize: FontSize.s17,
              ),
              BlurContainer(
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "age".tr(),
                          style: getBoldStyle(
                            color: AppColors.black,
                            fontSize: context.setSp(FontSize.s16),
                          ),
                        ),
                        SizedBox(height: context.setHeight(8)),

                        CustomTextFormField(
                          controller: bloc.ageController,
                          validator: (value) => Validator.validateAge(value),
                          keyboardType: TextInputType.number,
                          hintText: "enterAgeHint".tr(),
                          hintStyle: getRegularStyle(color: AppColors.gray[600]??AppColors.gray),
                        ),
                        SizedBox(height: context.setHeight(15)),
                        Text(
                          "gender".tr(),
                          style: getBoldStyle(
                            color: AppColors.black,
                            fontSize: context.setSp(FontSize.s16),
                          ),
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: "male",
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                              splashRadius: 0,
                            ),
                            Text(
                              "male".tr(),
                              style: getRegularStyle(
                                color: AppColors.black,
                                fontSize: context.setSp(FontSize.s16),
                              ),
                            ),
                            SizedBox(width: context.setWidth(20)),
                            Radio<String>(
                              value: "female",
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                            ),
                            Text(
                              "female".tr(),
                              style: getRegularStyle(
                                color: AppColors.black,
                                fontSize: context.setSp(FontSize.s16),
                              ),
                            ),
                          ],
                        ),
                        CaregiversSection(
                          controller: bloc.caregiverIdController,
                          caregiverIds: state.caregiverIds,
                          hasCaregiver: state.hasCaregiver,
                          onChange: (value) => bloc
                              .add(SetHasCaregiverEvent(value!)),
                          onAdd: (value) => bloc.add(
                            AddCaregiverIdEvent(value),
                          ),
                        ),
                      ],

                ),
              ),



              Padding(
                padding:  EdgeInsets.symmetric(horizontal: context.setWidth(38)),
                child: CustomElevatedButton(onPressed: () {

                }, buttonLabel: "Continuer"),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.setWidth(38)),
                child: CustomElevatedButton(onPressed: () {
                  if (bloc.formKey.currentState!.validate()) {
                    final ElderOnboardingRequest request=ElderOnboardingRequest(
                        age: int.parse(bloc.ageController.text),
                        gender: selectedGender,
                        caregiverIds: state.caregiverIds

                    );
                    bloc.add(SubmitElderOnboardingDataEvent(request));
                  }
                }, buttonLabel: "Complete Later"),
              ),
            ],
          ),
        );
      },
    );
  }
}
