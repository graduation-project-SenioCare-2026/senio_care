import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/loaders/loaders.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_entity.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/health_reports/health_report_item.dart';
import 'package:senio_care/features/elder/presentation/view_model/health_reports/health_reports_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/health_reports/health_reports_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HealthReportBody extends StatelessWidget {
  const HealthReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HealthReportsBloc, HealthReportsState>(
      buildWhen: (previous, current) =>
      previous.getHealthReports != current.getHealthReports,
      listener: (context, state) {
        if (state.getHealthReports.isFailure) {
          Loaders.showErrorMessage(
            message: state.getHealthReports.error!.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.getHealthReports.isLoading;
        final reports = state.getHealthReports.data ?? [];

        if (!isLoading && reports.isEmpty) {
          return Center(
            child: Text(
              'noHealthReportsFound'.tr(),
              style: getRegularStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
          );
        }

        return Skeletonizer(
          enabled: isLoading,
          child: ListView.builder(
            itemCount: isLoading ? 5 : reports.length,
            itemBuilder: (context, index) => HealthReportItem(
              index: index,
              report: isLoading
                  ? HealthReportEntity(
                reportId: '',
                userId: '',
                reportType: 'weekly',
                periodStart: DateTime.now().toString().substring(0, 10),
                periodEnd: DateTime.now().toString().substring(0, 10),
                title: 'reportTitle',
                overallStatus: 'good',
                generatedAt: '',
              )
                  : reports[index],
            ),
          ),
        );
      },
    );
  }
}