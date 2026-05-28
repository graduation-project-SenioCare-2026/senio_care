import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_entity.dart';

import '../../../../../../core/routes/routes_names.dart';

class HealthReportItem extends StatefulWidget {
  final int                index;
  final HealthReportEntity report;
  final bool               isNew;

  const HealthReportItem({
    required this.index,
    required this.report,
    this.isNew = false,
    super.key,
  });

  @override
  State<HealthReportItem> createState() => _HealthReportItemState();
}

class _HealthReportItemState extends State<HealthReportItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double>   _scale;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 600),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.025).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
    if (widget.isNew) _pulse.repeat(reverse: true, count: 3);
  }

  @override
  void didUpdateWidget(HealthReportItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isNew && !oldWidget.isNew) {
      _pulse.repeat(reverse: true, count: 3);
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RoutesNames.healthReportDetailsScreen,
        arguments: widget.report,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.setWidth(25)),
        child: widget.isNew
            ? _NewReportCard(report: widget.report)
            : CustomCard(child: _ReportRow(report: widget.report)),
      ),
    );

    return widget.isNew
        ? ScaleTransition(scale: _scale, child: child)
        : child;
  }
}

// ─── Shared row ────────────────────────────────────────────────
class _ReportRow extends StatelessWidget {
  const _ReportRow({required this.report});
  final HealthReportEntity report;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientIconContainer(
          width:  context.setWidth(55),
          height: context.setHeight(60),
          radius: context.setMinSize(60),
          child: Image.asset(
            AppIcons.medicalDoc,
            height: context.setHeight(45),
            width:  context.setWidth(45),
          ),
        ),
        SizedBox(width: context.setWidth(7)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                report.title,
                style: getBoldStyle(
                  color:    AppColors.black,
                  fontSize: context.setSp(FontSize.s18),
                ),
              ),
              Text(
                report.generatedAt,
                style: getRegularStyle(
                  color:    AppColors.black,
                  fontSize: context.setSp(FontSize.s14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── New-report highlighted card ───────────────────────────────
class _NewReportCard extends StatelessWidget {
  const _NewReportCard({required this.report});
  final HealthReportEntity report;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:   const EdgeInsets.symmetric(vertical: 6),
      padding:  EdgeInsets.all(context.setWidth(12)),
      decoration: BoxDecoration(
        color:        AppColors.gradientEnd.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gradientEnd, width: 1.8),
        boxShadow: [
          BoxShadow(
            color:        AppColors.gradientEnd.withOpacity(0.18),
            blurRadius:   12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GradientIconContainer(
            width:  context.setWidth(55),
            height: context.setHeight(60),
            radius: context.setMinSize(60),
            child: Image.asset(
              AppIcons.medicalDoc,
              height: context.setHeight(45),
              width:  context.setWidth(45),
            ),
          ),
          SizedBox(width: context.setWidth(7)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        report.title,
                        style: getBoldStyle(
                          color:    AppColors.black,
                          fontSize: context.setSp(FontSize.s18),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color:        AppColors.gradientEnd,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.auto_awesome,
                              size: 11, color: Colors.white),
                          const SizedBox(width: 3),
                          Text(
                            "new",
                            style: getRegularStyle(
                              color:    Colors.white,
                              fontSize: context.setSp(FontSize.s12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  report.generatedAt,
                  style: getRegularStyle(
                    color:    AppColors.black,
                    fontSize: context.setSp(FontSize.s14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}