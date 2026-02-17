import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_bloc.dart';

import '../../../../../../../../core/common_widgets/app_form_field.dart';
import '../../../../../../../../core/validator/validator.dart';
import 'elder_id_edit_section.dart';

class CaregiverEditCard extends StatelessWidget {
  const CaregiverEditCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CaregiverEditProfileBloc>();
    return SliverPadding(
      padding: EdgeInsets.all(context.setWidth(25)),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          CustomCard(
            child: Form(
              key: bloc.formKey,
              child: Column(
                children: [
                  AppFormField(
                    label: "phoneNumber".tr(),
                    controller: bloc.phoneNumberController,
                    keyboardType: TextInputType.number,
                    validator: (value) => Validator.validatePhoneNumber(value),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    hint: '',
                  ),
                  AppFormField(
                    label: "relationShip".tr(),
                    controller: bloc.relationShipController,
                    keyboardType: TextInputType.text,
                    validator: (value) => Validator.validateRequired(value),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    hint: '',
                  ),
                  ElderIdsEditSection()
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
