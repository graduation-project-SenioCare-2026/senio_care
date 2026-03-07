import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/setting_drawer.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/views/screens/service_provider_home_tap.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_event.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/views/screens/service_provider_profile_tab.dart';

import '../../../../config/di/di.dart';
import '../../../../core/common_widgets/bg_gradient.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/routes/routes_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/font_manager.dart';
import '../../../../core/theme/font_style.dart';
import '../../../../core/user/profile_manager.dart';
import '../../../../core/user/user_manager.dart';

class ServiceProviderMainLayout extends StatefulWidget {
  const ServiceProviderMainLayout({super.key});

  @override
  State<ServiceProviderMainLayout> createState() =>
      _ServiceProviderMainLayoutState();
}

class _ServiceProviderMainLayoutState extends State<ServiceProviderMainLayout> {
  int currentIndex = 0;
  final ServiceProviderEditProfileBloc _profileBloc = getIt<ServiceProviderEditProfileBloc>();

  @override
  void initState() {
    super.initState();
    final user = UserManager().user;
    if (user?.id != null) {
      _profileBloc.add(GetServiceProviderByIdEvent(user!.id!));
    }
  }

  @override
  void dispose() {
    _profileBloc.close();
    super.dispose();
  }

  List<String> get appBarTitles => ["myService".tr(), "personalInformation".tr()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileBloc,
      child: Stack(
        children: [
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
                title: Text(
                  appBarTitles[currentIndex],
                  style: getBoldStyle(
                    color: AppColors.black,
                    fontSize: context.setSp(FontSize.s24),
                  ),
                ),
                actions: currentIndex == 1
                    ? [
                  GestureDetector(
                    onTap: () async {
                      final wasUpdated = await Navigator.pushNamed(
                        context,
                        RoutesNames.serviceProviderEditProfile,
                      );
                      if (wasUpdated == true && context.mounted) {
                        final id = ProfileManager().serviceProvider?.id;
                        if (id != null) {
                          _profileBloc.add(GetServiceProviderByIdEvent(id));
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: context.setWidth(10),
                      ),
                      child: Image.asset(
                        AppIcons.editInfo,
                        color: AppColors.black,
                        width: context.setWidth(30),
                        height: context.setHeight(30),
                      ),
                    ),
                  ),
                ]
                    : null,
              ),
              endDrawer: SettingDrawer(),
              body: IndexedStack(
                index: currentIndex,
                children: [
                  ServiceProviderHomeTap(),
                  ServiceProviderProfileTab(),
                ],
              ),
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
                    selectedIconTheme: IconThemeData(size: 28),
                    unselectedIconTheme: IconThemeData(size: 23),
                    showUnselectedLabels: true,
                    showSelectedLabels: true,
                    onTap: (index) => setState(() => currentIndex = index),
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
          ),
        ],
      ),
    );
  }
}
