import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_home_tab/home_navigation_item.dart';

class ElderHomeTab extends StatefulWidget {
  const ElderHomeTab({super.key});

  @override
  State<ElderHomeTab> createState() => _ElderHomeTab();
}

class _ElderHomeTab extends State<ElderHomeTab> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: context.setWidth(26)),
      child: Column(
        children: [
          SizedBox(height: context.setHeight(50),),
          HomeNavigationItem(
            itemIcon: AppIcons.pills,
            itemLable: "medicines".tr(),
            description: "medicinesDescription".tr(),
            screenToNavigate: RoutesNames.dailyRemindersScreen,

          ),
          HomeNavigationItem(
              itemIcon: AppIcons.stars,
              itemLable: "aiHealthTips".tr(),
              description: "aiHealthTipsDescription".tr(),
            screenToNavigate: RoutesNames.tipsScreen,

          ),
          HomeNavigationItem(
              itemIcon: AppIcons.report,
              itemLable: "aiReports".tr(),
              description: "aiReportsDescription".tr(),
            screenToNavigate: RoutesNames.healthReportsScreen,

          ),

        ],
      ),
    );
  }
}
