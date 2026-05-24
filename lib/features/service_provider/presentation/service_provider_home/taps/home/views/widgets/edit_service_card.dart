import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/loading_btn.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import '../../../../../../../../core/common_widgets/app_form_field.dart';
import '../../../../../../../../core/common_widgets/custom_card.dart';
import '../../../../../../../../core/common_widgets/custom_elevated_button.dart';
import '../../../../../../../../core/user/profile_manager.dart';
import '../../../../../../api/models/request/home/availability_model.dart';
import '../../../../../../api/models/request/home/service_model.dart';
import '../../../../../../api/models/request/home/time_slots_model.dart';
import '../../view_model/services_bloc.dart';
import '../../view_model/services_event.dart';
import '../../view_model/services_state.dart';
import 'add_day_section.dart';

class EditServiceCard extends StatefulWidget {
  const EditServiceCard({super.key});

  @override
  State<EditServiceCard> createState() => _EditServiceCardState();
}

class _EditServiceCardState extends State<EditServiceCard> {
  bool _hasChanges(ServicesState state, ServicesBloc bloc) {
    final service = state.selectedService;
    if (service == null) return false;

    final descriptionChanged =
        bloc.descriptionController.text != (service.serviceDescription ?? '');

    final locationChanged =
        bloc.locationController.text != (service.location ?? '');

    final availabilityChanged = !_listsEqual(
      state.availability.entries
          .expand(
            (e) => e.value.map((s) => '${e.key}:${s.startTime}-${s.endTime}'),
          )
          .toList(),
      (service.availability ?? [])
          .expand(
            (a) => a.time.map((s) => '${a.day}:${s.startTime}-${s.endTime}'),
          )
          .toList(),
    );

    return descriptionChanged || locationChanged || availabilityChanged;
  }

  bool _listsEqual(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    final sortedA = [...a]..sort();
    final sortedB = [...b]..sort();
    for (int i = 0; i < sortedA.length; i++) {
      if (sortedA[i] != sortedB[i]) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ServicesBloc>();

    return BlocConsumer<ServicesBloc, ServicesState>(
      listenWhen: (prev, curr) =>
          prev.editServiceStatus != curr.editServiceStatus,
      listener: (context, state) {
        if (state.editServiceStatus.isSuccess) {
          bloc.add(ClearFormEvent());
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final hasChanges = _hasChanges(state, bloc);

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: context.setHeight(20),
            horizontal: context.setWidth(16),
          ),
          child: Column(
            children: [
              CustomCard(
                child: Form(
                  key: bloc.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppFormField(
                        label: "description".tr(),
                        controller: bloc.descriptionController,
                      ),
                      AppFormField(
                        label: "location".tr(),
                        controller: bloc.locationController,
                      ),

                      AddDaySection(
                        initialDays: state.availability.keys.toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: context.setHeight(20)),

              state.editServiceStatus.isLoading
                  ? LoadingBtn()
                  : CustomElevatedButton(
                      width: context.setWidth(350),
                      isLoading: state.editServiceStatus.isLoading,
                      onPressed: hasChanges
                          ? () {
                              if (bloc.formKey.currentState!.validate()) {
                                final request = ServiceRequest(
                                  availability: state.availability.entries.map((
                                    entry,
                                  ) {
                                    return AvailabilityModel(
                                      day: entry.key,
                                      time: entry.value.map((slot) {
                                        return TimeSlotsModel(
                                          startTime: slot.startTime,
                                          endTime: slot.endTime,
                                        );
                                      }).toList(),
                                    );
                                  }).toList(),
                                  isAvailable: true,
                                  serviceDescription:
                                      bloc.descriptionController.text,
                                  location: bloc.locationController.text,
                                  phoneNumber:
                                      state.selectedService?.phoneNumber,
                                  id: ProfileManager().serviceProvider?.id,
                                  userId:
                                      ProfileManager().serviceProvider?.userId,
                                );
                                bloc.add(
                                  EditServiceEvent(
                                    state.selectedService?.id ?? '',
                                    request,
                                  ),
                                );
                              }
                            }
                          : null,
                      buttonLabel: 'save'.tr(),
                    ),
            ],
          ),
        );
      },
    );
  }
}
