import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_event.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/views/widgets/service_provider_edit_profile_body.dart';

import '../../../../../../../../core/common_widgets/bg_gradient.dart';
import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';

class ServiceProviderEditProfile extends StatelessWidget {
  const ServiceProviderEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white.withOpacity(0.9)),
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'editProfile'.tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: FontSize.s30,
              ),
            ),
            centerTitle: true,
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
          body: BlocProvider(
            create: (_) =>
                getIt<ServiceProviderEditProfileBloc>()
                  ..add(ServiceProviderInitProfile()),
            child: ServiceProviderEditProfileBody(),
          ),
        ),
      ],
    );
  }
}
