import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/loading_btn.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

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
  late bool _isAvailable;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ServicesBloc>();
    _isAvailable = bloc.state.selectedService?.isAvailable ?? true;
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
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: context.setHeight(20),
            horizontal: context.setWidth(16),
          ),
          child: CustomCard(
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

                  AddDaySection(initialDays: state.availability.keys.toList()),

                  SizedBox(height: context.setHeight(16)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'isAvailable'.tr(),
                        style: getBoldStyle(
                          color: AppColors.black,
                          fontSize: context.setSp(FontSize.s16),
                        ),
                      ),
                      Switch(
                        activeThumbColor: AppColors.blue,
                        value: _isAvailable,
                        onChanged: (val) => setState(() => _isAvailable = val),
                      ),
                    ],
                  ),

                  SizedBox(height: context.setHeight(20)),

                  state.editServiceStatus.isLoading
                      ? LoadingBtn()
                      : CustomElevatedButton(
                          width: context.setWidth(300),
                          onPressed: () {
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
                                isAvailable: _isAvailable,
                                serviceDescription:
                                    bloc.descriptionController.text,
                                location: bloc.locationController.text,
                                phoneNumber: state.selectedService?.phoneNumber,
                                id: ProfileManager().serviceProvider?.id,
                              );
                              bloc.add(
                                EditServiceEvent(
                                  state.selectedService?.id ?? '',
                                  request,
                                ),
                              );
                            }
                          },
                          buttonLabel: 'save'.tr(),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
