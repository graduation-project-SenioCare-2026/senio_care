import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/views/widgets/add_service_card.dart';

import '../../../../../../../../core/common_widgets/bg_gradient.dart';
import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';
import '../../view_model/services_bloc.dart';

class AddServicesScreen extends StatelessWidget {
  const AddServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ServicesBloc>(),
      child: Stack(
        children: [
          BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
          Scaffold(
            appBar: AppBar(
              title: Text(
                "addNewServices".tr(),
                style: getBoldStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s24),
                ),
              ),
              leading: IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios)),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
            body: AddServiceCard(),
          ),
        ],
      ),
    );
  }
}
