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
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 0,
            maxWidth: double.infinity,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Header (Avatar + Name + Email)
              Row(
                children: [
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
                      width: context.setWidth(45),
                      height: context.setHeight(45),
                      color: Colors.grey[300],
                      child: const Icon(Icons.person, size: 30),
                    ),
                  ),
                  SizedBox(width: context.setWidth(8)),
          
                  /// 🔥 مهم جدًا
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.user?.name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getBoldStyle(
                            color: AppColors.black,
                            fontSize: context.setSp(FontSize.s16),
                          ),
                        ),
                        Text(
                          user?.user?.email ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getRegularStyle(
                            color: AppColors.black,
                            fontSize: context.setSp(FontSize.s12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: context.setHeight(10)),
          
              /// 🔹 Description
              Text(
                service.serviceDescription ?? "",
                style: getRegularStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s16),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
          
              SizedBox(height: context.setHeight(8)),

              /// 🔹 Phone
              Row(
                children: [
                  SizedBox(
                    width: context.setWidth(15),
                    height: context.setHeight(15),
                    child: Image.asset(
                      AppIcons.phone,
                      fit: BoxFit.contain,   // 👈 force it to stay within SizedBox
                    ),
                  ),
                  SizedBox(width: context.setWidth(8)),  // 👈 reduce this spacing
                  Expanded(
                    child: Text(
                      service.phoneNumber ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: getRegularStyle(
                        color: AppColors.gray[700]!,
                        fontSize: context.setSp(14),
                      ),
                    ),
                  ),
                ],
              ),

              /// 🔹 Location
              Row(
                children: [
                  SizedBox(
                    width: context.setWidth(15),
                    height: context.setHeight(15),
                    child: Image.asset(
                      AppIcons.location,
                      fit: BoxFit.contain,   // 👈 same fix
                    ),
                  ),
                  SizedBox(width: context.setWidth(8)),
                  Expanded(
                    child: Text(
                      service.location ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: getRegularStyle(
                        color: AppColors.gray[700]!,
                        fontSize: context.setSp(14),
                      ),
                    ),
                  ),
                ],
              ),
          
              Divider(color: Colors.grey.shade200),
          
              /// 🔹 Availability
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
          
                // ✅ Wrap each AvailabilityRow to prevent unbounded width
                ...service.availability!.map(
                      (avail) => SizedBox(
                    width: double.infinity,       // 👈 forces it to fill parent width
                    child: AvailabilityRow(availability: avail),
                  ),
                ),
              ],
              /// 🔹 Button
              Padding(
                padding: EdgeInsets.only(top: context.setHeight(10)),
                child: CustomElevatedButton(
                  onPressed: service.isAvailable == false
                      ? null
                      : () async {
                    final url =
                    Uri.parse("tel:${service.phoneNumber}");
                    await launchUrl(url);
                  },
                  buttonLabel: "contactProvider".tr(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}