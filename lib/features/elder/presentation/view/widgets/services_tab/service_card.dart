import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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

class ServiceCard extends StatelessWidget {
  final ServicesEntity service;
  const ServiceCard({required this.service, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      enableElevation: true,
      child: Padding(
        padding: EdgeInsets.all(context.setWidth(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
