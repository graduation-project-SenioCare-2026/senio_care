import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/views/widgets/edit_delete_icon.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_style.dart';
import '../../../../../../domain/entity/service_entity.dart';
import 'availability_row.dart';

class ServiceProviderCard extends StatelessWidget {
  final ServicesEntity? service;

  const ServiceProviderCard({required this.service, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.setWidth(16),
        vertical: context.setHeight(10),
      ),
      padding: EdgeInsets.all(context.setWidth(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description
              Text(
                service?.serviceDescription ?? '',
                style: getBoldStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(16),
                ),
              ),
              SizedBox(height: context.setHeight(10)),

              // Location
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, color: AppColors.blue, size: 18),
                  SizedBox(width: context.setWidth(4)),
                  Expanded(
                    child: Text(
                      service?.location ?? '',
                      style: getRegularStyle(
                        color: Colors.grey.shade600,
                        fontSize: context.setSp(12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.setHeight(10)),

              // Phone
              Row(
                children: [
                  Icon(Icons.phone, color: AppColors.blue, size: 18),
                  SizedBox(width: context.setWidth(4)),
                  Text(
                    service?.phoneNumber ?? '',
                    style: getRegularStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),

              if (service?.availability != null &&
                  service!.availability!.isNotEmpty) ...[
                SizedBox(height: context.setHeight(16)),
                Divider(color: Colors.grey.shade200),
                SizedBox(height: context.setHeight(8)),
                Row(
                  children: [
                    Icon(Icons.work, color: AppColors.blue, size: 18),
                    SizedBox(width: context.setWidth(4)),
                    Text(
                      'schedule'.tr(),
                      style: getBoldStyle(color: AppColors.black, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: context.setHeight(8)),
                ...service!.availability!.map(
                      (avail) => AvailabilityRow(availability: avail),
                ),
              ],
            ],
          ),
        ),
        EditDeleteIcon(service: service),
      ],
    ),
    );
  }
}
