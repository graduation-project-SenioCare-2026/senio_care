import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/validator/validator.dart';

import '../../../../../../../../core/common_widgets/app_form_field.dart';
import '../../../../../../../../core/common_widgets/custom_card.dart';
import '../../../../../../../../core/common_widgets/custom_elevated_button.dart';
import '../../../../../../../../core/common_widgets/loading_btn.dart';
import '../../../../../../../../core/user/profile_manager.dart';
import '../../../../../../api/models/request/home/availability_model.dart';
import '../../../../../../api/models/request/home/service_model.dart';
import '../../../../../../api/models/request/home/time_slots_model.dart';
import '../../view_model/services_bloc.dart';
import '../../view_model/services_event.dart';
import '../../view_model/services_state.dart';
import 'add_day_section.dart';

class AddServiceCard extends StatefulWidget {
  const AddServiceCard({super.key});

  @override
  State<AddServiceCard> createState() => _AddServiceCardState();
}

class _AddServiceCardState extends State<AddServiceCard> {

  @override
  void initState() {
    super.initState();
    context.read<ServicesBloc>().add(ClearFormEvent());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ServicesBloc>();

    return BlocConsumer<ServicesBloc, ServicesState>(
      listenWhen: (previous, current) =>
      previous.addServiceStatus != current.addServiceStatus,
      listener: (context, state) {
        if (state.addServiceStatus.isSuccess) {
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
          child: Form(
            key: bloc.formKey,
            child: Column(
              children: [
                /// 🔹 CARD
                CustomCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppFormField(
                        label: "description".tr(),
                        controller: bloc.descriptionController,
                        validator: (val) =>
                            Validator.validateRequired(val),
                      ),
                      AppFormField(
                        label: "location".tr(),
                        controller: bloc.locationController,
                        validator: (val) =>
                            Validator.validateRequired(val),
                      ),
                      const AddDaySection(),
                    ],
                  ),
                ),

                SizedBox(height: context.setHeight(20)),

                if (state.addServiceStatus.isLoading)
                  LoadingBtn()
                else
                  CustomElevatedButton(
                    width: context.setWidth(350),
                    onPressed: () {
                      if (bloc.formKey.currentState!.validate()) {
                        final request = ServiceRequest(
                          availability:
                          state.availability.entries.map((entry) {
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
                          userId: ProfileManager()
                              .serviceProvider
                              ?.userId,
                          phoneNumber: ProfileManager()
                              .serviceProvider
                              ?.phoneNumber,
                          id: ProfileManager()
                              .serviceProvider
                              ?.id,
                        );

                        bloc.add(AddServiceEvent(request));
                      }
                    },
                    buttonLabel: 'save'.tr(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}