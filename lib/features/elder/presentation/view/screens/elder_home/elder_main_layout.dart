import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/common_widgets/bg_gradient.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/common_widgets/setting_drawer.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/taps/elder_home_tab.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/taps/elder_profile_tab.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/taps/services_tab.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/taps/sos_tab.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_bloc.dart';

class ElderHome extends StatefulWidget {
  const ElderHome({super.key});

  @override
  State<ElderHome> createState() => _ElderHomeState();
}

class _ElderHomeState extends State<ElderHome> {
  int currentIndex = 0;
  List<Widget> taps = [
    ElderHomeTab(),
    SosTab(),
    ServicesTab(),
    ElderProfileTap(),
  ];

  List<String> appBarTitles = [
    "${"welcome".tr()}, ${UserManager().name}",
    "emergencySos".tr(),
    "medicalServices".tr(),
    "myProfile".tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white.withOpacity(0.9)),
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
              title: FittedBox(
                child: Text(
                  appBarTitles[currentIndex],
                  style: getBoldStyle(
                    color: AppColors.black,
                    fontSize: context.setSp(FontSize.s24),
                  ),
                ),
              ),
            ),

            endDrawer: SettingDrawer(),
            body: taps[currentIndex],

            extendBody: true,
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
                  showUnselectedLabels: true,
                  showSelectedLabels: true,
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: currentIndex == 0
                            ? AppColors.blue
                            : AppColors.gray,
                      ),
                      label: "home".tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        AppIcons.emergency,
                        width: context.setWidth(20),
                        height: context.setHeight(20),
                        color: currentIndex == 1
                            ? AppColors.blue
                            : AppColors.gray,
                      ),
                      label: "sos".tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.medical_services,
                        color: currentIndex == 2
                            ? AppColors.blue
                            : AppColors.gray,
                      ),
                      label: "services".tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        color: currentIndex == 3
                            ? AppColors.blue
                            : AppColors.gray,
                      ),
                      label: "profile".tr(),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesNames.aiChatScreen);
              },
              child: GradientIconContainer(
                width: context.setWidth(60),
                height: context.setHeight(60),
                radius: context.setMinSize(30),
                child: Image.asset(
                  AppIcons.chat,
                  width: context.setWidth(50),
                  height: context.setHeight(50),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
