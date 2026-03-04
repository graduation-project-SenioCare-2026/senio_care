import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/views/widgets/add_service_card.dart';

import '../../../../../../../../core/common_widgets/bg_gradient.dart';
import '../../../../../../../../core/theme/app_colors.dart';


class AddServicesScreen extends StatelessWidget {
  const AddServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        Scaffold(
          appBar: AppBar(
            title: Text("addNewServices".tr()),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          body: AddServiceCard(),
        ),
      ],
    );
  }
}
