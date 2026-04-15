import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/graph/view_model/caregiver_graph_bloc.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/graph/view_model/caregiver_graph_state.dart';

import '../../../../../../../../core/common_widgets/bg_gradient.dart';
import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../widgets/weekly_line_chart.dart';

class OxygenScreen extends StatelessWidget {
  const OxygenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white.withOpacity(0.9)),
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        Scaffold(
          appBar: AppBar(
            title: Text(
              "oxygenLevel".tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s24),
              ),
            ),
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
                size: context.setWidth(25),
              ),
            ),
          ),
          body: BlocBuilder<CaregiverGraphBloc, CaregiverGraphState>(
            builder: (context, state) {
              final oxygen = state.getOxygenState.data;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: WeeklyLineChart(
                        data: oxygen ?? [],
                        normalRange: '95-100',
                        unit: '%'.tr(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
