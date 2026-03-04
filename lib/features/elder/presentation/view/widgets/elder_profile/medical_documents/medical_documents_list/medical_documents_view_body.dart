import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/loaders/loaders.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/domain/entity/medical_document_entity.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/medical_documents/medical_documents_list/document_item.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MedicalDocumentsViewBody extends StatelessWidget {
  const MedicalDocumentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicalDocumentsBloc, MedicalDocumentsState>(
      buildWhen: (previous, current) =>
      previous.getDocumentStatus != current.getDocumentStatus,
      listener: (context, state) {
        if (state.getDocumentStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.getDocumentStatus.error!.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.getDocumentStatus.isLoading;
        final documents = state.getDocumentStatus.data ?? [];

        if (!isLoading && documents.isEmpty) {
          return Center(
            child: Text(
              'noMedicalDocumentsFound'.tr(),
              style: getRegularStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
          );
        }

        return Skeletonizer(
          enabled: isLoading,
          child: ListView.builder(
            itemCount: isLoading ? 5 : documents.length,
            itemBuilder: (context, index) => DocumentItem(
              index: index,
              document: isLoading
                  ?MedicalDocumentEntity(
                id: '',
                date:DateTime.now().toString().substring(0,10),
                images: [], documentName: 'documentName',
              )
                  : documents[index],
            ),
          ),
        );
      },
    );
  }
}