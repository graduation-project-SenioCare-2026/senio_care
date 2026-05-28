import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_entity.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/health_reports/health_report_item.dart';

class HealthReportBody extends StatelessWidget {
  final HealthReportEntity? fakeNewReport;

  const HealthReportBody({super.key, this.fakeNewReport});

  static final List<HealthReportEntity> _fakeReports = [
    HealthReportEntity(
      reportId:      '1',
      userId:        'user_123',
      reportType:    'weekly',
      periodStart:   '2025-05-07',
      periodEnd:     '2025-05-14',
      title:         'Weekly Health Report',
      overallStatus: 'good',
      generatedAt:   '21-04-2026',
    ),
    HealthReportEntity(
      reportId:      '2',
      userId:        'user_123',
      reportType:    'monthly',
      periodStart:   '2025-04-01',
      periodEnd:     '2025-04-30',
      title:         'Monthly Health Report',
      overallStatus: 'good',
      generatedAt:   '05-03-2026',
    ),
    HealthReportEntity(
      reportId:      '3',
      userId:        'user_123',
      reportType:    'daily',
      periodStart:   '2025-05-20',
      periodEnd:     '2025-05-20',
      title:         'Daily Health Report',
      overallStatus: 'good',
      generatedAt:   '01-01-2026',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final hasFake = fakeNewReport != null;
    final allReports = [
      if (hasFake) fakeNewReport!,
      ..._fakeReports,
    ];

    if (allReports.isEmpty) {
      return Center(
        child: Text(
          'noHealthReportsFound'.tr(),
          style: getRegularStyle(
            color:    AppColors.black,
            fontSize: context.setSp(FontSize.s16),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: allReports.length,
      itemBuilder: (context, index) => HealthReportItem(
        index:  index,
        report: allReports[index],
        isNew:  hasFake && index == 0,
      ),
    );
  }
}