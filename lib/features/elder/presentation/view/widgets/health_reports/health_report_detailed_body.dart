import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/loaders/loaders.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import '../../../view_model/health_reports/health_reports_bloc.dart';
import '../../../view_model/health_reports/health_reports_state.dart';

class HealthReportDetailsBody extends StatelessWidget {
  const HealthReportDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HealthReportsBloc, HealthReportsState>(
      buildWhen: (previous, current) =>
      previous.getReportDetails != current.getReportDetails,
      listener: (context, state) {
        if (state.getReportDetails.isFailure) {
          Loaders.showErrorMessage(
            message: state.getReportDetails.error!.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.getReportDetails.isLoading;
        final report = state.getReportDetails.data;

        if (isLoading) {
          return Skeletonizer(
            enabled: true,
            child: Padding(
              padding: EdgeInsets.all(context.setWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  8,
                      (i) => Padding(
                    padding: EdgeInsets.only(bottom: context.setHeight(12)),
                    child: Container(
                      height: context.setHeight(18),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.gray,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        if (report == null) {
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

        return Markdown(
          data: report.content,
          styleSheet: MarkdownStyleSheet(
            p: getRegularStyle(
              color: AppColors.black,
              fontSize: context.setSp(FontSize.s14),
            ),
            h1: getBoldStyle(
              color: AppColors.black,
              fontSize: context.setSp(FontSize.s22),
            ),
            h2: getBoldStyle(
              color: AppColors.black,
              fontSize: context.setSp(FontSize.s20),
            ),
            h3: getBoldStyle(
              color: AppColors.black,
              fontSize: context.setSp(FontSize.s18),
            ),
            strong: getBoldStyle(
              color: AppColors.black,
              fontSize: context.setSp(FontSize.s14),
            ),
            listBullet: getRegularStyle(
              color: AppColors.black,
              fontSize: context.setSp(FontSize.s14),
            ),
            blockquoteDecoration: BoxDecoration(
              color: AppColors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border(
                left: BorderSide(color: AppColors.blue, width: 4),
              ),
            ),
          ),
          padding: EdgeInsets.all(context.setWidth(20)),
        );
      },
    );
  }
}