import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/common_widgets/image_picker.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/elder_profile/full_screen_viewer.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/medical_documents/create_document/add_image_button.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/medical_documents/create_document/image_tile.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_state.dart';

class DocumentImagesSection extends StatelessWidget {
  final MedicalDocumentsState state;

  const DocumentImagesSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<List<File>>(
      initialValue: state.selectedImages,
      validator: (images) {
        if (images == null || images.isEmpty) {
          return 'pleaseSelectImage'.tr();
        }
        return null;
      },
      builder: (fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'attachImages'.tr(),
                  style: getBoldStyle(
                    color: AppColors.black,
                    fontSize: context.setSp(FontSize.s16),
                  ),
                ),
                if (state.selectedImages.isNotEmpty)
                  Text(
                    '${state.selectedImages.length} ${'images'.tr()}',
                    style: getRegularStyle(
                      color: AppColors.gray[400]!,
                      fontSize: context.setSp(FontSize.s13),
                    ),
                  ),
              ],
            ),
            SizedBox(height: context.setHeight(10)),

            LayoutBuilder(
              builder: (context, constraints) {
                const crossAxisCount = 2;
                const spacing = 6.0;

                final itemSize =
                    (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
                        crossAxisCount;

                final items = [
                  ...state.selectedImages,
                  null,
                ];

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: items.map((file) {
                    final isAddButton = file == null;
                    final index =
                    isAddButton ? -1 : state.selectedImages.indexOf(file);

                    return SizedBox(
                      width: itemSize,
                      height: itemSize,
                      child: isAddButton
                          ? AddImageButton(
                        isUploading: state.isUploading,
                        onTap: () async {
                          final files =
                          await ImagePickerHelper.pickImages(context);

                          if (files.isNotEmpty && context.mounted) {
                            context.read<MedicalDocumentsBloc>().add(
                              SelectImagesEvent([
                                ...state.selectedImages,
                                ...files,
                              ]),
                            );
                            fieldState.didChange([
                              ...state.selectedImages,
                              ...files,
                            ]);
                          }
                        },
                      )
                          : ImageTile(
                        file: file,
                        index: index,
                        progress: state.uploadProgress.length > index
                            ? state.uploadProgress[index]
                            : 0.0,
                        isUploading: state.isUploading,
                        onRemove: state.isUploading
                            ? null
                            : () {
                          final updated =
                          List<File>.from(state.selectedImages)
                            ..removeAt(index);

                          context.read<MedicalDocumentsBloc>().add(
                            SelectImagesEvent(updated),
                          );
                          fieldState.didChange(updated);
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FullScreenViewer(
                                images: state.selectedImages,
                                initialIndex: index,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),


            if (fieldState.hasError)
              Padding(
                padding: EdgeInsets.only(top: context.setHeight(6)),
                child: Text(
                  fieldState.errorText!,
                  style:getRegularStyle(color: AppColors.red),
                ),
              )
          ],
        );
      },
    );
  }
}