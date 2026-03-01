import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/common_widgets/app_form_field.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/common_widgets/loading_btn.dart';
import 'package:senio_care/core/loaders/loaders.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/validator/validator.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/medical_documents/create_document/document_date_picker.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/medical_documents/create_document/document_images_section.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_state.dart';

class CreateDocumentCard extends StatefulWidget {
  const CreateDocumentCard({super.key});

  @override
  State<CreateDocumentCard> createState() => _CreateDocumentCardState();
}

class _CreateDocumentCardState extends State<CreateDocumentCard> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveDocument(BuildContext context, MedicalDocumentsState state) {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (!formValid) return;

    final selectedDate = state.selectedDate ?? DateTime.now();
    context.read<MedicalDocumentsBloc>().add(PickDateEvent(selectedDate));

    context.read<MedicalDocumentsBloc>().add(const SaveDocumentEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicalDocumentsBloc, MedicalDocumentsState>(
      listener: (context, state) {
        if(state.createDocumentStatus.isFailure){
          Loaders.showErrorMessage(message: state.createDocumentStatus.error!.message, context: context);
        }
        if(state.createDocumentStatus.isSuccess){
          Loaders.showSuccessMessage(message: "documentAddedSuccessfully".tr(), context: context);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: context.setWidth(26)),
          child: Column(
            children: [
              SizedBox(height: context.setHeight(40)),
              CustomCard(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppFormField(
                        label: 'DocumentName'.tr(),
                        controller: _nameController,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: Validator.validateDocumentName,
                        onChange: (value) {
                          context.read<MedicalDocumentsBloc>().add(
                            ChangeDocumentNameEvent(value),
                          );
                        },
                      ),

                      DocumentDatePicker(state: state),

                      DocumentImagesSection(state: state),
                    ],
                  ),
                ),
              ),

              SizedBox(height: context.setHeight(15)),

              state.createDocumentStatus.isLoading
                  ? const Center(child: LoadingBtn())
                  : CustomElevatedButton(
                      buttonLabel: 'save'.tr(),
                      onPressed: () => _saveDocument(context, state),
                    ),
              SizedBox(height: context.setHeight(20)),
            ],
          ),
        );
      },
    );
  }
}
