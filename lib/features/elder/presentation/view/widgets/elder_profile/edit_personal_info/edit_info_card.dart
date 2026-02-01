import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/app_form_field.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/validator/validator.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/edit_personal_info/allergies_edit_section.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/edit_personal_info/blood_type_edit.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/edit_personal_info/caregivers_edit_section.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/edit_personal_info/diseases_edit_section.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/edit_personal_info/mobility_status_edit.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';

class EditInfoCard extends StatefulWidget {
  const EditInfoCard({super.key});

  @override
  State<EditInfoCard> createState() => _EditInfoCardState();
}

class _EditInfoCardState extends State<EditInfoCard> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ElderProfileBloc>();

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: context.setWidth(25)),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          CustomCard(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppFormField(
                    label: "age".tr(),
                    controller: bloc.ageController,
                    keyboardType: TextInputType.number,
                    validator: (value) => Validator.validateAge(value),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),

                  AppFormField(
                    label: "weight".tr(),
                    controller: bloc.weightController,
                    keyboardType: TextInputType.number,
                    validator: (value) => Validator.validateWeight(value),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),

                  AppFormField(
                    label: "height".tr(),
                    controller: bloc.heightController,
                    keyboardType: TextInputType.number,
                    validator: (value) => Validator.validateHeight(value),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),

                  SizedBox(height: context.setHeight(15)),

                  const DiseasesEditSection(),
                  const AllergiesEditSection(),
                  const BloodTypeEdit(),
                  const MobilityStatusEdit(),
                  const CaregiversEditSection(),
                ],
              ),
            ),
          ),
          SizedBox(height: context.setHeight(20)),
        ]),
      ),
    );
  }
}
