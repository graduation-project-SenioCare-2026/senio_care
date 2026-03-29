import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_style.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDateChanged;

  const CustomDatePicker({
    super.key,
    this.initialDate,
    this.onDateChanged,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _selectedDate;
  final ScrollController _scrollController = ScrollController();

  final DateTime _firstDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  late final DateTime _lastDate;

  @override
  void initState() {
    super.initState();
    _lastDate = _firstDate.add(const Duration(days: 7));
    _selectedDate = widget.initialDate ?? _firstDate;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<DateTime> _generateDates() {
    final days = _lastDate.difference(_firstDate).inDays + 1;
    return List.generate(days, (i) => _firstDate.add(Duration(days: i)));
  }

  String _dayName(BuildContext context, int weekday) {
    final isArabic = context.locale.languageCode == 'ar';
    const enNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const arNames = ['إثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة', 'سبت', 'أحد'];
    return isArabic ? arNames[weekday - 1] : enNames[weekday - 1];
  }

  String _toArabicNumerals(int number) {
    const western = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic  = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number.toString().split('').map((d) {
      final i = western.indexOf(d);
      return i != -1 ? arabic[i] : d;
    }).join();
  }

  @override
  Widget build(BuildContext context) {
    final dates   = _generateDates();
    final isArabic = context.locale.languageCode == 'ar';

    final double cardW    = context.setWidth(60);
    final double cardH    = context.setHeight(76);
    final double gap      = context.setWidth(5);
    final double dotD     = context.setMinSize(7);
    final double padTop   = context.setHeight(5);
    final double padDot   = context.setHeight(4);
    final double rowH     = padTop + cardH + padDot + dotD+context.setHeight(7);

    return SizedBox(
      height: rowH,
      child: ListView.builder(
        controller:      _scrollController,
        scrollDirection: Axis.horizontal,
        reverse:         isArabic,
        padding: EdgeInsets.symmetric(horizontal: context.setWidth(16)),
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date       = dates[index];
          final isSelected = date.year  == _selectedDate.year  &&
              date.month == _selectedDate.month &&
              date.day   == _selectedDate.day;

          return GestureDetector(
            onTap: () {
              setState(() => _selectedDate = date);
              widget.onDateChanged?.call(date);
            },
            child: SizedBox(
              width:  cardW + gap,
              height: rowH,
              child: Stack(
                children: [
                  // ── Card ──────────────────────────────
                  Positioned(
                    top:   padTop,
                    left:  isArabic ? gap : 0,
                    right: isArabic ? 0   : gap,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width:  cardW,
                      height: cardH,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.white
                            : AppColors.gray[200],
                        borderRadius:
                        BorderRadius.circular(context.setMinSize(16)),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.blue
                              : Colors.transparent,
                          width: context.setMinSize(2),
                        ),
                        boxShadow: isSelected
                            ? [
                          BoxShadow(
                            color:      AppColors.blue.withOpacity(0.25),
                            blurRadius: context.setMinSize(10),
                            offset:     Offset(0, context.setHeight(4)),
                          ),
                        ]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _dayName(context, date.weekday),
                            style: getBoldStyle(
                              color: isSelected
                                  ? AppColors.blue
                                  : AppColors.black[300]!,
                              fontSize: context.setSp(isArabic ? 10 : 12),
                            ),
                          ),
                          SizedBox(height: context.setHeight(2)),
                          Text(
                            isArabic
                                ? _toArabicNumerals(date.day)
                                : '${date.day}',
                            style: getBoldStyle(
                              color: isSelected
                                  ? AppColors.blue
                                  : AppColors.black,
                              fontSize: context.setSp(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Dot ───────────────────────────────
                  Positioned(
                    top:   padTop + cardH + padDot,
                    left:  0,
                    right: gap,
                    child: Center(
                      child: Container(
                        width:  dotD,
                        height: dotD,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? AppColors.blue
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}