import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/auth/presentation/view_model/user_session_view_model/user_session_bloc.dart';
import 'package:senio_care/features/auth/presentation/view_model/user_session_view_model/user_session_event.dart';

class SettingDrawer extends StatelessWidget {
  const SettingDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserManager();
    return Drawer(
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          SizedBox(
            height: context.setHeight(120),
            child: DrawerHeader(
              child: Column(
                children: [
                  Text(
                    user.name ?? "Unknown User",
                    style: getBoldStyle(
                      color: AppColors.black[600]!,
                      fontSize: context.setSp(FontSize.s18),
                    ),
                  ),
                  Text(
                    user.email ?? "Unknown User",
                    style: getRegularStyle(
                      color: AppColors.gray[700]!,
                      fontSize: context.setSp(FontSize.s14),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.language, size: context.setMinSize(25)),
            title: Text(
              'language'.tr(),
              style: getRegularStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
            onTap: () {
              _showLanguageDialog(context);
            },
          ),

          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red,
              size: context.setMinSize(25),
            ),
            title: Text(
              'logout'.tr(),
              style: getRegularStyle(
                color: AppColors.red,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, RoutesNames.rolesScreen);
              context.read<SessionBloc>().add(SignOutEvent());
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(context.setMinSize(20))

      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Row(
              children: [
                Text('english'.tr()),
                Spacer(),
                context.locale == Locale("en")
                    ? Icon(
                        Icons.check_circle,
                        size: context.setMinSize(35),
                        color: AppColors.gradientStart,
                      )
                    : SizedBox(),
              ],
            ),
            onTap: () {
              context.setLocale(const Locale('en'));
              Navigator.pop(context);
            },
          ),
          Divider(color: AppColors.gray[600]),
          ListTile(
            title: Row(
              children: [
                Text('arabic'.tr()),
                Spacer(),
                context.locale == Locale("ar")
                    ? Icon(
                        Icons.check_circle,
                        size: context.setMinSize(30),
                        color: AppColors.gradientStart,
                      )
                    : SizedBox(),
              ],
            ),
            onTap: () {
              context.setLocale(const Locale('ar'));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
