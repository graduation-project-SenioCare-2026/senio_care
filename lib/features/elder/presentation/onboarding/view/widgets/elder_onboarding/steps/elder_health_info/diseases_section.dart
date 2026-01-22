import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/disease_entity.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_health_info/multi_select_drop_down/custom_multi_select_dropdown.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_event.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_state.dart';

class DiseasesSection extends StatelessWidget {
  const DiseasesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElderOnboardingBloc, ElderOnboardingState>(
      buildWhen: (prev, curr) =>
          prev.diseasesStatus != curr.diseasesStatus ||
          prev.selectedDiseases != curr.selectedDiseases,
      builder: (context, state) {
        final diseases = state.diseasesStatus.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "chronicDisease".tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
            CustomMultiSelectDropdown<DiseaseEntity>(
              parentContext: context,
              items: diseases,
              selectedItems: state.selectedDiseases,
              onItemsSelected: (selectedDiseases) {
                context.read<ElderOnboardingBloc>().add(
                  SetSelectedDiseasesEvent(selectedDiseases),
                );
              },
              itemAsString: (disease) =>
                  context.locale == Locale("en") ? disease.en : disease.ar,
              itemAsStringSecondary: (disease) =>
                  context.locale == Locale("en") ? disease.ar : disease.en,
              compareFn: (i1, i2) => i1.en == i2.en,
              hintText: "chronicDisease".tr(),
              searchHintText: "searchDisease".tr(),
              emptyResultText: "noResults".tr(),
              prefixIcon: Icons.medical_services_rounded,
              showChips: true,
              onChipDeleted: (disease) {
                context.read<ElderOnboardingBloc>().add(
                  RemoveDiseaseEvent(disease),
                );
              },
              otherOptionHint: "enterCustomDisease".tr(),
              createCustomItem: (text) {
                return DiseaseEntity(en: text, ar: text);
              },
            ),
            SizedBox(height: context.setHeight(8)),
          ],
        );
      },
    );
  }
}
