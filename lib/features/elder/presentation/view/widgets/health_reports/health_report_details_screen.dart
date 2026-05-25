import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/bg_gradient.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_entity.dart';

import '../../../view_model/health_reports/health_reports_bloc.dart';
import '../../../view_model/health_reports/health_reports_event.dart';
import 'health_report_detailed_body.dart';

class HealthReportDetailsScreen extends StatefulWidget {
  final HealthReportEntity report;

  const HealthReportDetailsScreen({required this.report, super.key});

  @override
  State<HealthReportDetailsScreen> createState() =>
      _HealthReportDetailsScreenState();
}

class _HealthReportDetailsScreenState extends State<HealthReportDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HealthReportsBloc>().add(
      GetReportDetails(UserManager().userId!, widget.report.reportId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white.withOpacity(0.9)),
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
                size: context.setWidth(25),
              ),
            ),
            title: FittedBox(
              child: Text(
                widget.report.title,
                style: getBoldStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s20),
                ),
              ),
            ),
          ),
          body: const HealthReportDetailsBody(),
        ),
      ],
    );
  }
}
