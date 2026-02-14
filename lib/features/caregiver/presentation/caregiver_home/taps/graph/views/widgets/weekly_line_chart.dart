import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/features/caregiver/domain/entity/graph/weekly_metric_entity.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_style.dart';

class WeeklyLineChart extends StatefulWidget {
  final List<WeeklyMetricEntity> data;
  final List<WeeklyMetricEntity>? secondaryData; // For blood pressure diastolic
  final String normalRange;
  final String? secondaryNormalRange; // For diastolic range
  final String unit;
  final Color primaryColor;
  final Color secondaryColor;
  final Color? tertiaryColor; // For diastolic line
  final bool isBloodPressure; // Flag for blood pressure
  final String? primaryLabel; // e.g., "Systolic"
  final String? secondaryLabel; // e.g., "Diastolic"

  const WeeklyLineChart({
    super.key,
    required this.data,
    this.secondaryData,
    required this.normalRange,
    this.secondaryNormalRange,
    required this.unit,
    this.primaryColor = const Color(0xFF4A90E2), // Default blue
    this.secondaryColor = const Color(0xFF589BE8), // Default lighter blue
    this.tertiaryColor, // Will default to red for diastolic
    this.isBloodPressure = false,
    this.primaryLabel,
    this.secondaryLabel,
  });

  @override
  State<WeeklyLineChart> createState() => _WeeklyLineChartState();
}

class _WeeklyLineChartState extends State<WeeklyLineChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Helper method to check if value is in normal range
  bool _isValueNormal(double value, String range) {
    try {
      final parts = range.split('-');
      if (parts.length != 2) return true; // Can't determine, show as normal

      final min = double.tryParse(parts[0].trim());
      final max = double.tryParse(parts[1].trim());

      if (min == null || max == null) return true;

      return value >= min && value <= max;
    } catch (e) {
      return true; // Default to normal if parsing fails
    }
  }

  // Get status color and text
  Map<String, dynamic> _getStatus(double value, String range) {
    final isNormal = _isValueNormal(value, range);
    return {
      'isNormal': isNormal,
      'text': isNormal ? 'Normal' : 'Abnormal',
      'color': isNormal
          ? const Color(0xFF4CAF50)
          : const Color(0xFFFF9800), // Green : Orange
      'icon': isNormal ? Icons.check_circle : Icons.warning_amber_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Center(
        child: Text(
          'No data available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    // Combine both datasets to find min/max if blood pressure
    final allValues = <double>[
      ...widget.data.map((e) => e.value),
      if (widget.secondaryData != null)
        ...widget.secondaryData!.map((e) => e.value),
    ];

    final minValue = allValues.reduce((a, b) => a < b ? a : b);
    final maxValue = allValues.reduce((a, b) => a > b ? a : b);

    // Get the latest (current) values
    final currentValue = widget.data.last.value;
    final currentSecondaryValue = widget.secondaryData?.last.value;

    // Calculate average values
    final averageValue =
        widget.data.map((e) => e.value).reduce((a, b) => a + b) /
        widget.data.length;

    final averageSecondaryValue = widget.secondaryData != null
        ? widget.secondaryData!.map((e) => e.value).reduce((a, b) => a + b) /
              widget.secondaryData!.length
        : null;

    // Get tertiary color for diastolic
    final diastolicColor = widget.tertiaryColor ?? const Color(0xFFE74C3C);

    // Get status for current values
    final primaryStatus = _getStatus(currentValue, widget.normalRange);
    final secondaryStatus =
        widget.isBloodPressure &&
            currentSecondaryValue != null &&
            widget.secondaryNormalRange != null
        ? _getStatus(currentSecondaryValue, widget.secondaryNormalRange!)
        : null;

    return Column(
      children: [
        // Current Value Box
        Container(
          padding: EdgeInsets.all(context.setHeight(14)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: widget.isBloodPressure && currentSecondaryValue != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Systolic Value
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.primaryLabel ?? 'systolic'.tr(),
                                style: getRegularStyle(
                                  color: AppColors.gray,
                                  fontSize: context.setSp(FontSize.s12),
                                ),
                              ),
                              SizedBox(width: context.setWidth(6)),
                              // Status Badge
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.setWidth(6),
                                  vertical: context.setHeight(2),
                                ),
                                decoration: BoxDecoration(
                                  color: primaryStatus['color'].withOpacity(
                                    0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: primaryStatus['color'].withOpacity(
                                      0.3,
                                    ),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      primaryStatus['icon'],
                                      size: context.setSp(10),
                                      color: primaryStatus['color'],
                                    ),
                                    SizedBox(width: context.setWidth(3)),
                                    Text(
                                      primaryStatus['text'],
                                      style: getRegularStyle(
                                        color: primaryStatus['color'],
                                        fontSize: context.setSp(FontSize.s12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: context.setHeight(4)),
                          Text(
                            '${currentValue.toInt()} ${widget.unit}',
                            style: getRegularStyle(
                              color: widget.primaryColor,
                              fontSize: context.setSp(FontSize.s18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Divider
                    Container(
                      height: 50,
                      width: 1,
                      color: AppColors.gray.withOpacity(0.3),
                    ),
                    SizedBox(width: context.setWidth(16)),
                    // Diastolic Value
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.secondaryLabel ?? 'diastolic'.tr(),
                                style: getRegularStyle(
                                  color: AppColors.gray,
                                  fontSize: context.setSp(FontSize.s12),
                                ),
                              ),
                              if (secondaryStatus != null) ...[
                                SizedBox(width: context.setWidth(6)),
                                // Status Badge
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.setWidth(6),
                                    vertical: context.setHeight(2),
                                  ),
                                  decoration: BoxDecoration(
                                    color: secondaryStatus['color'].withOpacity(
                                      0.15,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: secondaryStatus['color']
                                          .withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        secondaryStatus['icon'],
                                        size: context.setSp(10),
                                        color: secondaryStatus['color'],
                                      ),
                                      SizedBox(width: context.setWidth(3)),
                                      Text(
                                        secondaryStatus['text'],
                                        style: getRegularStyle(
                                          color: secondaryStatus['color'],
                                          fontSize: context.setSp(FontSize.s12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: context.setHeight(4)),
                          Text(
                            '${currentSecondaryValue.toInt()} ${widget.unit}',
                            style: getRegularStyle(
                              color: diastolicColor,
                              fontSize: context.setSp(FontSize.s18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Current Value
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'currentValue'.tr(),
                              style: getRegularStyle(
                                color: AppColors.gray,
                                fontSize: context.setSp(FontSize.s12),
                              ),
                            ),
                            SizedBox(width: context.setWidth(8)),
                            // Status Badge
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.setWidth(8),
                                vertical: context.setHeight(3),
                              ),
                              decoration: BoxDecoration(
                                color: primaryStatus['color'].withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: primaryStatus['color'].withOpacity(
                                    0.3,
                                  ),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    primaryStatus['icon'],
                                    size: context.setSp(12),
                                    color: primaryStatus['color'],
                                  ),
                                  SizedBox(width: context.setWidth(4)),
                                  Text(
                                    primaryStatus['text'],
                                    style: getRegularStyle(
                                      color: primaryStatus['color'],
                                      fontSize: context.setSp(FontSize.s12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.setHeight(4)),
                        Text(
                          '${currentValue.toInt()} ${widget.unit}',
                          style: getRegularStyle(
                            color: AppColors.black,
                            fontSize: context.setSp(FontSize.s18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
        SizedBox(height: context.setHeight(16)),

        // Average Rate Box
        Container(
          padding: EdgeInsets.all(context.setHeight(14)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: widget.isBloodPressure && averageSecondaryValue != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Systolic Average
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Average ${widget.primaryLabel ?? 'Systolic'}',
                            style: getRegularStyle(
                              color: AppColors.gray,
                              fontSize: context.setSp(FontSize.s12),
                            ),
                          ),
                          SizedBox(height: context.setHeight(4)),
                          Text(
                            '${averageValue.toInt()} ${widget.unit}',
                            style: getRegularStyle(
                              color: widget.primaryColor,
                              fontSize: context.setSp(FontSize.s18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Divider
                    Container(
                      height: 50,
                      width: 1,
                      color: AppColors.gray.withOpacity(0.3),
                    ),
                    SizedBox(width: context.setWidth(16)),
                    // Diastolic Average
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Average ${widget.secondaryLabel ?? 'Diastolic'}',
                            style: getRegularStyle(
                              color: AppColors.gray,
                              fontSize: context.setSp(FontSize.s12),
                            ),
                          ),
                          SizedBox(height: context.setHeight(4)),
                          Text(
                            '${averageSecondaryValue.toInt()} ${widget.unit}',
                            style: getRegularStyle(
                              color: diastolicColor,
                              fontSize: context.setSp(FontSize.s18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'averageRate'.tr(),
                          style: getRegularStyle(
                            color: AppColors.gray,
                            fontSize: context.setSp(FontSize.s12),
                          ),
                        ),
                        SizedBox(height: context.setHeight(4)),
                        Text(
                          '${averageValue.toInt()} ${widget.unit}',
                          style: getRegularStyle(
                            color: AppColors.black,
                            fontSize: context.setSp(FontSize.s18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
        SizedBox(height: context.setHeight(16)),

        // Graph Box
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(context.setHeight(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Normal Range Info and Legend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Normal Range
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Normal Range: ${widget.normalRange} ${widget.unit}',
                              style: getRegularStyle(
                                color: AppColors.gray,
                                fontSize: context.setSp(FontSize.s12),
                              ),
                            ),

                            // Legend for blood pressure
                            if (widget.isBloodPressure &&
                                widget.secondaryData != null)
                              Row(
                                children: [
                                  // Systolic Legend
                                  Container(
                                    width: 16,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: widget.primaryColor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  SizedBox(width: context.setWidth(4)),
                                  Text(
                                    widget.primaryLabel ?? 'systolic'.tr(),
                                    style: getRegularStyle(
                                      color: AppColors.gray,
                                      fontSize: context.setSp(FontSize.s12),
                                    ),
                                  ),
                                  SizedBox(width: context.setWidth(12)),
                                  // Diastolic Legend
                                  Container(
                                    width: 16,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: diastolicColor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  SizedBox(width: context.setWidth(4)),
                                  Text(
                                    widget.secondaryLabel ?? 'diastolic'.tr(),
                                    style: getRegularStyle(
                                      color: AppColors.gray,
                                      fontSize: context.setSp(FontSize.s12),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.setHeight(20)),

                  // Chart
                  Expanded(
                    child: LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: (widget.data.length - 1).toDouble(),
                        minY: minValue - 20,
                        maxY: maxValue + 20,

                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          horizontalInterval: 20,
                          verticalInterval: 1,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.grey.withOpacity(0.2),
                              strokeWidth: 1,
                              dashArray: [5, 5],
                            );
                          },
                          getDrawingVerticalLine: (value) {
                            return FlLine(
                              color: Colors.grey.withOpacity(0.2),
                              strokeWidth: 1,
                              dashArray: [5, 5],
                            );
                          },
                        ),

                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                            width: 1,
                          ),
                        ),

                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              interval: 20,
                              getTitlesWidget: (value, meta) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: context.setWidth(6),
                                  ),
                                  child: Text(
                                    value.toInt().toString(),
                                    style: getRegularStyle(
                                      color: AppColors.gray.shade600,
                                      fontSize: context.setSp(FontSize.s12),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                if (value.toInt() >= 0 &&
                                    value.toInt() < widget.data.length) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      top: context.setHeight(6),
                                    ),
                                    child: Text(
                                      widget.data[value.toInt()].day,
                                      style: getRegularStyle(
                                        color: AppColors.gray.shade600,
                                        fontSize: context.setSp(FontSize.s12),
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ),

                        lineBarsData: [
                          // Primary line (Systolic or regular data)
                          LineChartBarData(
                            spots: widget.data
                                .asMap()
                                .entries
                                .map(
                                  (e) => FlSpot(
                                    e.key.toDouble(),
                                    minValue +
                                        (e.value.value - minValue) *
                                            _animation.value,
                                  ),
                                )
                                .toList(),
                            isCurved: true,
                            curveSmoothness: 0.35,
                            color: widget.secondaryColor,
                            barWidth: 3,
                            isStrokeCapRound: true,

                            belowBarData: BarAreaData(
                              show: !widget
                                  .isBloodPressure, // Only show gradient for single line
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  widget.primaryColor.withOpacity(
                                    0.3 * _animation.value,
                                  ),
                                  widget.primaryColor.withOpacity(
                                    0.05 * _animation.value,
                                  ),
                                ],
                              ),
                            ),

                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: 4 * _animation.value,
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                  strokeColor: widget.primaryColor,
                                );
                              },
                            ),

                            shadow: Shadow(
                              color: widget.primaryColor.withOpacity(
                                0.3 * _animation.value,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ),

                          // Secondary line (Diastolic) if blood pressure
                          if (widget.isBloodPressure &&
                              widget.secondaryData != null)
                            LineChartBarData(
                              spots: widget.secondaryData!
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) => FlSpot(
                                      e.key.toDouble(),
                                      minValue +
                                          (e.value.value - minValue) *
                                              _animation.value,
                                    ),
                                  )
                                  .toList(),
                              isCurved: true,
                              curveSmoothness: 0.35,
                              color: diastolicColor,
                              barWidth: 3,
                              isStrokeCapRound: true,

                              belowBarData: BarAreaData(show: false),

                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 4 * _animation.value,
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                    strokeColor: diastolicColor,
                                  );
                                },
                              ),

                              shadow: Shadow(
                                color: diastolicColor.withOpacity(
                                  0.3 * _animation.value,
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ),
                        ],

                        lineTouchData: LineTouchData(
                          enabled: true,
                          touchTooltipData: LineTouchTooltipData(
                            tooltipPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((spot) {
                                if (widget.isBloodPressure &&
                                    widget.secondaryData != null) {
                                  // Show both systolic and diastolic in tooltip
                                  final index = spot.x.toInt();
                                  final systolic = widget.data[index].value;
                                  final diastolic =
                                      widget.secondaryData![index].value;

                                  return LineTooltipItem(
                                    '${systolic.toInt()}/${diastolic.toInt()} ${widget.unit}\n${widget.data[index].day}',
                                    TextStyle(
                                      color: spot.barIndex == 0
                                          ? widget.primaryColor
                                          : diastolicColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  );
                                } else {
                                  final originalValue =
                                      widget.data[spot.x.toInt()].value;
                                  return LineTooltipItem(
                                    '${originalValue.toInt()} ${widget.unit}\n${widget.data[spot.x.toInt()].day}',
                                    const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  );
                                }
                              }).toList();
                            },
                          ),
                          getTouchedSpotIndicator: (barData, spotIndexes) {
                            return spotIndexes.map((index) {
                              final color =
                                  barData.color ?? widget.primaryColor;
                              return TouchedSpotIndicatorData(
                                FlLine(
                                  color: color,
                                  strokeWidth: 2,
                                  dashArray: [5, 5],
                                ),
                                FlDotData(
                                  show: true,
                                  getDotPainter:
                                      (spot, percent, barData, index) {
                                        return FlDotCirclePainter(
                                          radius: 7,
                                          color: Colors.white,
                                          strokeWidth: 3,
                                          strokeColor: color,
                                        );
                                      },
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
