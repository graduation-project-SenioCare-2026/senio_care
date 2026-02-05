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
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_state.dart';

class AllergiesSection extends StatelessWidget {
  const AllergiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElderOnboardingBloc, ElderOnboardingState>(
      buildWhen: (prev, curr) =>
      prev.allergiesStatus != curr.allergiesStatus ||
          prev.selectedAllergies != curr.selectedAllergies,
      builder: (context, state) {
        final allergies = state.allergiesStatus.data ?? [];

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
            CustomMultiSelectDropdown<AllergyEntity>(
              parentContext: context,
              items: allergies,
              selectedItems: state.selectedAllergies,
              onItemsSelected: (items) {
                context.read<ElderOnboardingBloc>().add(
                  SetSelectedAllergiesEvent(items),
                );
              },
              itemAsString: (e) =>
              context.locale.languageCode == 'en' ? e.en : e.ar,
              itemAsStringSecondary: (e) =>
              context.locale.languageCode == 'en' ? e.ar : e.en,
              compareFn: (i1, i2) => i1.en == i2.en,
              hintText: "allergies".tr(),
              searchHintText: "searchAllergy".tr(),
              emptyResultText: "noResults".tr(),
              prefixIcon: Icons.coronavirus,
              showChips: true,
              onChipDeleted: (item) {
                context.read<ElderOnboardingBloc>().add(
                  RemoveAllergyEvent(item),
                );
              },
              otherOptionHint: "enterCustomAllergy".tr(),
              createCustomItem: (text) =>
                  AllergyEntity(en: text, ar: text),
            ),
            SizedBox(height: context.setHeight(8)),
          ],
        );
      },
    );
  }
}
