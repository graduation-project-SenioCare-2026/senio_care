import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/availability_row.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../view_model/services/services_bloc.dart';


class ServiceCard extends StatelessWidget {
  final ServicesEntity service;
  const ServiceCard({required this.service, super.key});

  @override
  Widget build(BuildContext context) {
    final usersMap = context.watch<ServicesBloc>().state.usersMap;

    final user = usersMap?[service.userId];
    return CustomCard(
      enableElevation: true,
      child: Padding(
        padding: EdgeInsets.all(context.setWidth(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // GradientIconContainer(
                //   width: context.setWidth(45),
                //   height: context.setHeight(45),
                //   radius: context.setSp(80),
                //   childPadding: context.setWidth(5),
                //   child:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: (user?.user?.avatar?.isNotEmpty ?? false)
                        ? Image.network(
                      user!.user!.avatar!,
                      fit: BoxFit.cover,
                      width: context.setWidth(45),
                      height: context.setHeight(45),
                    )
                        : Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.person, size: 30),
                    ),
                  ),
                //),
                SizedBox(width: context.setWidth(5),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.user?.name??"",

                      style: getRegularStyle(
                        color: AppColors.black,
                        fontSize: context.setSp(FontSize.s18),
                      ),
                    ),
                    Text(
                      user?.user?.email??"",
                      style: getRegularStyle(
                        color: AppColors.gray,
                        fontSize: context.setSp(FontSize.s12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: context.setHeight(10),),
            Text(
              service.serviceDescription!,
              style: getRegularStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s14),
              ),
            ),
            Row(
              children: [
                Image.asset(
                  AppIcons.phone,
                  height: context.setHeight(15),
                  width: context.setWidth(15),
                ),
                SizedBox(width: context.setWidth(15)),
                Text(
                  service.phoneNumber!,
                  style: getRegularStyle(
                    color: AppColors.gray[700]!,
                    fontSize: context.setSp(14),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  AppIcons.location,
                  height: context.setHeight(15),
                  width: context.setWidth(15),
                ),
                SizedBox(width: context.setWidth(15)),
                Text(
                  service.location!,
                  style: getRegularStyle(
                    color: AppColors.gray[700]!,
                    fontSize: context.setSp(14),
                  ),
                ),
              ],
            ),

            Divider(color: Colors.grey.shade200),
            if (service.availability != null &&
                service.availability!.isNotEmpty) ...[
              SizedBox(height: context.setHeight(10)),
              Text(
                'availableDays'.tr(),
                style: getRegularStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s14),
                ),
              ),
              SizedBox(height: context.setHeight(6)),
              ...service.availability!.map(
                (avail) => AvailabilityRow(availability: avail),
              ),
            ],

            Padding(
              padding: EdgeInsets.only(top: context.setHeight(10)),
              child: CustomElevatedButton(
                onPressed: service.isAvailable == false
                    ? null
                    : () async {
                        final url = Uri.parse("tel:${service.phoneNumber}");
                        await launchUrl(url);
                      },
                buttonLabel: "contactProvider".tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
