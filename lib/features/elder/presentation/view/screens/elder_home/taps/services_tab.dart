import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/services_tab/service_card.dart';
import 'package:senio_care/features/elder/presentation/view_model/services/services_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/services/services_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/services/services_state.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ServicesTab extends StatelessWidget {
  const ServicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.setHeight(10),
        bottom: context.setHeight(20),
        right: context.setWidth(25),
        left: context.setWidth(25),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "browseAvailableHealthcareServices".tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s17),
              ),
            ),
            SizedBox(height: context.setHeight(10)),

            BlocProvider(
              create: (context) =>
                  getIt<ServicesBloc>()..add(GetAllServicesEvent()),
              child: BlocBuilder<ServicesBloc, ServicesState>(
                builder: (context, state) {
                  final servicesState = state.getAllServicesState;

                  if (servicesState.isLoading) {
                    return ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Skeletonizer(
                        enabled: true,

                        child: ServiceCard(
                          service: ServicesEntity(
                            userId: "",
                            id: "",
                            phoneNumber: "01144521452",
                            serviceDescription: 'Service Name',
                            location: 'Service Description',
                            availability: [],
                            isAvailable: null,
                          ),
                        ),
                      ),
                    );
                  }

                  final services = servicesState.data;
                  if (services == null || services.isEmpty) {
                    return Center(
                      child: Text(
                        "NoServicesFound".tr(),
                        style: getRegularStyle(
                          color: AppColors.black,
                          fontSize: context.setSp(FontSize.s16),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: services.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        ServiceCard(service: services[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
