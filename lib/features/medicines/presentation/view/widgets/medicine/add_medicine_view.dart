import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import '../../../../../../core/common_widgets/bg_gradient.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/font_manager.dart';
import '../../../../../../core/theme/font_style.dart';

import 'add_medicine_card.dart';

class AddMedicineView extends StatelessWidget {
  final String elderId;
  const AddMedicineView({super.key, required this.elderId});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'addNewReminder'.tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s24),
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: AddMedicineCard(elderId: elderId),
        ),
      ],
    );
  }
}