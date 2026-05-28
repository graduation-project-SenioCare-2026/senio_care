import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/common_widgets/bg_gradient.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/domain/entity/health_report_entity.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_home_tab/report_period.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/health_reports/health_report_body.dart';
import 'package:senio_care/features/elder/presentation/view_model/health_reports/health_reports_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/health_reports/health_reports_event.dart';

class HealthReportsScreen extends StatefulWidget {
  const HealthReportsScreen({super.key});

  @override
  State<HealthReportsScreen> createState() => _HealthReportsScreenState();
}

class _HealthReportsScreenState extends State<HealthReportsScreen> {
  // The fake newly-generated report (null until user generates one)
  HealthReportEntity? _fakeNewReport;

  final List<ReportPeriod> _periods = [
    ReportPeriod(key: "daily",   label: "Daily Report"),
    ReportPeriod(key: "weekly",  label: "Weekly Report"),
    ReportPeriod(key: "monthly", label: "Monthly Report"),
  ];

  // ── Period picker ──────────────────────────────────────────────
  void _showPeriodDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: AppColors.gray, width: 1.2),
        ),
        title: Row(
          children: [
            Icon(Icons.date_range, size: 25, color: AppColors.gradientEnd),
            const SizedBox(width: 10),
            Text(
              "selectPeriod".tr(),
              style: getRegularStyle(
                color:    AppColors.gradientEnd,
                fontSize: context.setSp(FontSize.s20),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _periods.map((period) {
            return ListTile(
              title: Text(period.label),
              onTap: () {
                Navigator.pop(dialogContext);
                _startSimulation(period);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── Simulation ─────────────────────────────────────────────────
  void _startSimulation(ReportPeriod period) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _GeneratingReportDialog(
        periodLabel: period.label,
        onComplete: () {
          Navigator.of(context, rootNavigator: true).pop();
          _addFakeReport(period);
        },
      ),
    );
  }

  void _addFakeReport(ReportPeriod period) {
    final now = DateTime.now();
    String fmt(DateTime d) => d.toIso8601String().substring(0, 10);

    String start, end;
    if (period.key == 'daily') {
      start = end = fmt(now);
    } else if (period.key == 'weekly') {
      start = fmt(now.subtract(const Duration(days: 6)));
      end   = fmt(now);
    } else {
      start = fmt(DateTime(now.year, now.month, 1));
      end   = fmt(DateTime(now.year, now.month + 1, 0));
    }

    setState(() {
      _fakeNewReport = HealthReportEntity(
        reportId:      'fake_${DateTime.now().millisecondsSinceEpoch}',
        userId:        'user_123',
        reportType:    period.key,
        periodStart:   start,
        periodEnd:     end,
        title:         period.label,
        overallStatus: 'good',
        generatedAt:   fmt(now),
      );
    });
  }

  // ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<HealthReportsBloc>()..add(GetReports('user_123')),
      child: Stack(
        children: [
          Container(color: Colors.white.withOpacity(0.9)),
          BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor:        Colors.transparent,
              centerTitle:            true,
              elevation:              0,
              scrolledUnderElevation: 0,
              surfaceTintColor:       Colors.transparent,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                  size:  context.setWidth(25),
                ),
              ),
              title: FittedBox(
                child: Text(
                  "aiReports".tr(),
                  style: getBoldStyle(
                    color:    AppColors.black,
                    fontSize: context.setSp(FontSize.s24),
                  ),
                ),
              ),
            ),
            floatingActionButton: GestureDetector(
              onTap: _showPeriodDialog,
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  end:    context.setWidth(8),
                  bottom: context.setHeight(8),
                ),
                child: GradientIconContainer(
                  width:        context.setWidth(55),
                  height:       context.setHeight(60),
                  radius:       context.setMinSize(60),
                  childPadding: 0,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size:  context.setWidth(50),
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
            // Pass the fake report down to the body
            body: HealthReportBody(fakeNewReport: _fakeNewReport),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  Progress dialog
// ═══════════════════════════════════════════════════════════════
class _GeneratingReportDialog extends StatefulWidget {
  const _GeneratingReportDialog({
    required this.periodLabel,
    required this.onComplete,
  });

  final String       periodLabel;
  final VoidCallback onComplete;

  @override
  State<_GeneratingReportDialog> createState() =>
      _GeneratingReportDialogState();
}

class _GeneratingReportDialogState extends State<_GeneratingReportDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double>   _progress;
  Timer? _completeTimer;

  // ← change to 50 for production
  static const int _durationSeconds = 5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync:    this,
      duration: const Duration(seconds: _durationSeconds),
    );
    _progress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
    _completeTimer = Timer(
      const Duration(seconds: _durationSeconds),
      widget.onComplete,
    );
  }

  @override
  void dispose() {
    _completeTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: AppColors.gray, width: 1.2),
        ),
        content: AnimatedBuilder(
          animation: _progress,
          builder: (context, _) {
            final pct = (_progress.value * 100).round();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _SpinningIcon(color: AppColors.gradientEnd),
                const SizedBox(height: 16),
                Text(
                  "Generating Report".tr(),
                  style: getBoldStyle(
                    color:    AppColors.black,
                    fontSize: context.setSp(FontSize.s18),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.periodLabel,
                  style: getRegularStyle(
                    color:    AppColors.gray,
                    fontSize: context.setSp(FontSize.s14),
                  ),
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value:           _progress.value,
                    minHeight:       10,
                    backgroundColor: AppColors.gray.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.gradientEnd,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "$pct%",
                  style: getBoldStyle(
                    color:    AppColors.gradientEnd,
                    fontSize: context.setSp(FontSize.s22),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Analyzing Health Data".tr(),
                  style: getRegularStyle(
                    color:    AppColors.gray,
                    fontSize: context.setSp(FontSize.s13),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ─── Spinning icon ─────────────────────────────────────────────
class _SpinningIcon extends StatefulWidget {
  const _SpinningIcon({required this.color});
  final Color color;

  @override
  State<_SpinningIcon> createState() => _SpinningIconState();
}

class _SpinningIconState extends State<_SpinningIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _spin;

  @override
  void initState() {
    super.initState();
    _spin = AnimationController(
      vsync:    this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _spin,
      child: Icon(Icons.auto_awesome, size: 40, color: widget.color),
    );
  }
}