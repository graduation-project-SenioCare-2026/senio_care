import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/elder_personal_info/avatar_name_container.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/elder_personal_info/info_card.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';

class ElderPersonalInfoViewBody extends StatelessWidget {
  const ElderPersonalInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            title: Text(
              "personalInformation".tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s24),
              ),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
                size: context.setWidth(25),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () async {
                  final wasUpdated = await Navigator.pushNamed(
                    context,
                    RoutesNames.elderEditProfile,
                  );


                  if (wasUpdated == true && context.mounted) {
                    final elderId = ProfileManager().elder?.id;
                    if (elderId != null) {
                      context.read<ElderProfileBloc>().add(GetElderEvent(elderId));
                    }
                  }
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: context.setWidth(10),
                  ),
                  child: Image.asset(
                    AppIcons.editInfo,
                    width: context.setWidth(30),
                    height: context.setHeight(30),
                  ),
                ),
              ),
            ],
          ),
          AvatarNameContainer(),
          InfoCard(),
        ],
      ),
    );
  }
}