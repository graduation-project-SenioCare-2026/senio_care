import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/setting_drawer.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/graph/views/screens/caregiver_graph_tab.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/home/views/screens/caregiver_home_tab.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/views/screen/caregiver_profile_tab.dart';

import '../../../../core/common_widgets/bg_gradient.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/font_manager.dart';
import '../../../../core/theme/font_style.dart';

class CaregiverMainLayout extends StatefulWidget {
  const CaregiverMainLayout({super.key});

  @override
  State<CaregiverMainLayout> createState() => _CaregiverMainLayoutState();
}

class _CaregiverMainLayoutState extends State<CaregiverMainLayout> {
  int currentIndex = 0;
  List<Widget> taps = [
    CaregiverHomeTab(),
    CaregiverGraphTab(),
    CaregiverProfileTab(),
  ];
  List<String> appBarTitles = [
    "home".tr(),
    "vitalsMonitoring".tr(),
    "myProfile".tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
    MediaQuery.removePadding(
    context: context,
    removeBottom: true,
        child:
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            title: Text(
              appBarTitles[currentIndex],
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s24),
              ),
            ),
          ),
          endDrawer: SettingDrawer(),
          extendBody: true,
          body: taps[currentIndex],
          bottomNavigationBar: Padding(
            padding:  EdgeInsets.all(context.setHeight(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                type: BottomNavigationBarType.fixed,
                elevation: 10,
                backgroundColor: AppColors.white,
                selectedItemColor: AppColors.gradientEnd,
                unselectedItemColor: AppColors.black.withAlpha(150),
                selectedIconTheme: IconThemeData(size: 30),
                unselectedIconTheme: IconThemeData(size: 25),
                showUnselectedLabels: true,
                showSelectedLabels: true,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "home".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bar_chart),
                    label: "graph".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "profile".tr(),
                  ),
                ],
              ),
            ),
          ),
        ),
    ),
      ],
    );
  }
}
