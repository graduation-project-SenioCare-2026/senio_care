import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_state.dart';

class DocumentDatePicker extends StatelessWidget {
  final MedicalDocumentsState state;

  const DocumentDatePicker({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'selectDate'.tr(),
          style: getBoldStyle(
            color: AppColors.black,
            fontSize: FontSize.s16,
          ),
        ),

        GestureDetector(
          onTap: () async {
            final date = await _selectDate(context);

            if (date != null && context.mounted) {
              context
                  .read<MedicalDocumentsBloc>()
                  .add(PickDateEvent(date));
            }
          },
          child: Center(
            child: Text(
              (state.selectedDate ?? DateTime.now())
                  .toString()
                  .substring(0, 10),
              style: getBoldStyle(
                color: AppColors.gray[600]!,
                fontSize: FontSize.s16,
              ),
            ),
          ),
        ),
        SizedBox(height: context.setHeight(10),)
      ],
    );
  }

  // Themed Date Picker
  Future<DateTime?> _selectDate(BuildContext context) async {

    return showDatePicker(
      context: context,
      initialDate: state.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: AppColors.blue,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.black,
              secondary: AppColors.white,
              onSecondary: Colors.transparent,
              error: Colors.red,
              onError: Colors.transparent,
            )
          ),
          child: child!,
        );
      },
    );
  }
}