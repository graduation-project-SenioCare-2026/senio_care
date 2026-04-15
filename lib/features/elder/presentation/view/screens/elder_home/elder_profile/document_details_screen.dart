import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/bg_gradient.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/domain/entity/medical_document_entity.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/medical_documents/document_details/documents_image_slider.dart';

class DocumentDetailsScreen extends StatelessWidget {
  final MedicalDocumentEntity document;

  const DocumentDetailsScreen({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white.withOpacity(0.9)),
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  elevation: 0,
                  title: Text(
                    document.documentName,
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

                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.setWidth(25),
                      vertical: context.setHeight(20),
                    ),
                    child: CustomCard(
                      child: Column(
                        children: [

                          Text(
                            "performedOn".tr(),
                            style: getBoldStyle(
                              color: AppColors.black,
                              fontSize: context.setSp(FontSize.s16),
                            ),
                          ),
                          Text(
                            document.date,
                            style: getRegularStyle(
                              color: AppColors.gray[600]!,
                              fontSize: context.setSp(FontSize.s16),
                            ),
                          ),

                          SizedBox(height: context.setHeight(20)),

                          DocumentImageSlider(images: document.images),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
