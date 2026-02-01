import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/edit_personal_info/edit_button.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/edit_personal_info/edit_info_card.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/elder_personal_info/avatar_name_container.dart';

class EditPersonalInfoViewBody extends StatelessWidget {
  const EditPersonalInfoViewBody({super.key});

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
              "editProfile".tr(),
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
          ),
          AvatarNameContainer(),
          EditInfoCard(),
          SliverToBoxAdapter(child: EditButton()),
        ],
      ),
    );
  }
}
