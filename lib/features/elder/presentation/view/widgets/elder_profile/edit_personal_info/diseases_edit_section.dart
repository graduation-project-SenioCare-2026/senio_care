import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/disease_entity.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_onboarding/steps/elder_health_info/multi_select_drop_down/custom_multi_select_dropdown.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_state.dart';

class DiseasesEditSection extends StatelessWidget {
  const DiseasesEditSection({super.key});

  @override
  Widget build(BuildContext context) {
    final availableDiseases = context.select(
          (ElderOnboardingBloc bloc) => bloc.state.diseasesStatus.data ?? [],
    );

    return BlocBuilder<ElderProfileBloc, ElderProfileState>(
      buildWhen: (previous, current) =>
      previous.selectedDiseases != current.selectedDiseases,
      builder: (context, profileState) {
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
            SizedBox(height: context.setHeight(8)),

            CustomMultiSelectDropdown<DiseaseEntity>(
              parentContext: context,
              items: availableDiseases,
              selectedItems: List<DiseaseEntity>.from(profileState.selectedDiseases),
              onItemsSelected: (selected) {
                final bloc = context.read<ElderProfileBloc>();
                for (var disease in selected) {
                  bloc.add(AddDiseaseEvent(disease));
                }
              },
              itemAsString: (disease) => context.locale == const Locale("en")
                  ? disease.en
                  : disease.ar,
              itemAsStringSecondary: (disease) =>
              context.locale == const Locale("en")
                  ? disease.ar
                  : disease.en,
              compareFn: (i1, i2) => i1.en == i2.en,
              hintText: "chronicDisease".tr(),
              searchHintText: "searchDisease".tr(),
              emptyResultText: "noResults".tr(),
              prefixIcon: Icons.medical_services_rounded,
              showChips: true,
              onChipDeleted: (disease) {
                context.read<ElderProfileBloc>().add(
                  RemoveDiseaseEditEvent(disease),
                );
              },
              otherOptionHint: "enterCustomDisease".tr(),
              createCustomItem: (text) {
                final newDisease = DiseaseEntity(en: text, ar: text);
                context.read<ElderProfileBloc>().add(
                  AddDiseaseEvent(newDisease),
                );
                return newDisease;
              },
            ),
          ],
        );
      },
    );
  }
}