import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/graph/views/widgets/graph_box.dart';

import '../../../../../../../../core/routes/routes_names.dart';
import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';

class GraphBody extends StatelessWidget {
  const GraphBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: context.setWidth(15),
              top: context.setHeight(15),
              bottom: context.setHeight(10),
            ),
            child: Text(
              "pickAMetricToExploreElderData".tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s18),
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Column(
            children: [
              GraphBox(
                routes: RoutesNames.bloodSugarGraph,
                title: "bloodSugar".tr(),
                value: "115",
                unit: "mgDl".tr(),
                icon: Icons.water_drop,
                color: Color(0xff31a534),
                bgIconColor: Color(0xffb1ecb4),
              ),
              GraphBox(
                routes: RoutesNames.heartRateGraph,
                title: "heartRate".tr(),
                value: "74",
                unit: "BPM".tr(),
                icon: Icons.favorite,
                color: Color(0xffd53236),
                bgIconColor: Color(0xfff8d9d9),
              ),
              GraphBox(
                routes: RoutesNames.oxygenGraph,
                title: "oxygenLevel".tr(),
                value: "98",
                unit: "%".tr(),
                icon: Icons.air,
                color: Color(0xff186bec),
                bgIconColor: Color(0xffb3cef4),
              ),
              GraphBox(
                routes: RoutesNames.bloodPressureGraph,
                title: "bloodPressure".tr(),
                value: "124/81",
                unit: "mmHg".tr(),
                icon: Icons.monitor_heart,
                color: Color(0xff5418ec),
                bgIconColor: Color(0xffcfb8f4),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
