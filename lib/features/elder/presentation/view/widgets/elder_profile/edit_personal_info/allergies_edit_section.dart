import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/allergy_entity.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_onboarding/steps/elder_health_info/multi_select_drop_down/custom_multi_select_dropdown.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_state.dart';

class AllergiesEditSection extends StatelessWidget {
  const AllergiesEditSection({super.key});

  @override
  Widget build(BuildContext context) {
    final availableAllergies = context.select(
          (ElderOnboardingBloc bloc) => bloc.state.allergiesStatus.data ?? [],
    );

    return BlocBuilder<ElderProfileBloc, ElderProfileState>(
      buildWhen: (previous, current) =>
      previous.selectedAllergies != current.selectedAllergies,
      builder: (context, profileState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "allergies".tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
            SizedBox(height: context.setHeight(8)),

            CustomMultiSelectDropdown<AllergyEntity>(
              parentContext: context,
              items: availableAllergies,
              selectedItems: List<AllergyEntity>.from(profileState.selectedAllergies),
              onItemsSelected: (selected) {
                final bloc = context.read<ElderProfileBloc>();
                for (var allergy in selected) {
                  bloc.add(AddAllergyEvent(allergy));
                }
              },
              itemAsString: (allergy) => context.locale == const Locale("en")
                  ? allergy.en
                  : allergy.ar,
              itemAsStringSecondary: (allergy) =>
              context.locale == const Locale("en") ? allergy.ar : allergy.en,
              compareFn: (i1, i2) => i1.en == i2.en,
              hintText: "allergies".tr(),
              searchHintText: "searchAllergy".tr(),
              emptyResultText: "noResults".tr(),
              prefixIcon: Icons.coronavirus,
              showChips: true,
              onChipDeleted: (allergy) {
                context.read<ElderProfileBloc>().add(
                  RemoveAllergyEditEvent(allergy),
                );
              },
              otherOptionHint: "enterCustomAllergy".tr(),
              createCustomItem: (text) {
                final newAllergy = AllergyEntity(en: text, ar: text);
                context.read<ElderProfileBloc>().add(AddAllergyEvent(newAllergy));
                return newAllergy;
              },
            ),
          ],
        );
      },
    );
  }
}