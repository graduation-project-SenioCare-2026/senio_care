import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/home/views/screen/caregiver_home_tab.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/views/screen/caregiver_profile_tab.dart';

import '../../../../core/common_widgets/bg_gradient.dart';
import '../../../../core/theme/app_colors.dart';

class CaregiverMainLayout extends StatefulWidget {
  const CaregiverMainLayout({super.key});

  @override
  State<CaregiverMainLayout> createState() => _CaregiverMainLayoutState();
}

class _CaregiverMainLayoutState extends State<CaregiverMainLayout> {
  int currentIndex = 0;
  List<Widget> taps = [CaregiverHomeTab(), CaregiverProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        Scaffold(
          body: taps[currentIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(15),
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
                showUnselectedLabels: false,
                showSelectedLabels: false,
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
                    icon: Icon(Icons.person),
                    label: "profile".tr(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
