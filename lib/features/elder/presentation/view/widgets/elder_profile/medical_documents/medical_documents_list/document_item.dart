import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/common_widgets/custom_dialog.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/domain/entity/medical_document_entity.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_state.dart';

class DocumentItem extends StatelessWidget {
  final int index;
  final MedicalDocumentEntity document;

  const DocumentItem({required this.index, required this.document, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RoutesNames.documentDetailsScreen,
        arguments: document,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.setWidth(25)),
        child: CustomCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientIconContainer(
                width: context.setWidth(55),
                height: context.setHeight(60),
                radius: context.setMinSize(60),
                child: Image.asset(
                  AppIcons.medicalDoc,
                  height: context.setHeight(45),
                  width: context.setWidth(45),
                ),
              ),
              SizedBox(width: context.setWidth(7)),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.documentName,
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: context.setSp(FontSize.s18),
                    ),
                  ),
                  Text(
                    document.date,
                    style: getRegularStyle(
                      color: AppColors.black,
                      fontSize: context.setSp(FontSize.s14),
                    ),
                  ),
                ],
              ),
              Spacer(),
              BlocBuilder<MedicalDocumentsBloc, MedicalDocumentsState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      final bloc = context.read<MedicalDocumentsBloc>();

                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            title: Text(
                              "AreYouSureToDeleteThisDocument".tr(),
                              style: getBoldStyle(
                                color: AppColors.black,
                                fontSize: context.setSp(FontSize.s18),
                              ),
                            ),
                            confirmText: "delete".tr(),
                            onConfirm: () => bloc.add(DeleteDocumentEvent(document.id)),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      color: AppColors.red,
                      size: context.setWidth(25),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
