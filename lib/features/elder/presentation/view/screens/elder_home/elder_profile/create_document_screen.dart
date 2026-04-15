import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/bg_gradient.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/medical_documents/create_document/create_document_card.dart';

class CreateDocumentScreen extends StatelessWidget {
  final String? elderId;
  const CreateDocumentScreen({super.key, this.elderId});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white.withOpacity(0.9)),
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "AddDocument".tr(),
                style: getBoldStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s24),
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                  size: context.setWidth(25),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: CreateDocumentCard(elderId: elderId),
            ),
          ),
        ),
      ],
    );
  }
}
