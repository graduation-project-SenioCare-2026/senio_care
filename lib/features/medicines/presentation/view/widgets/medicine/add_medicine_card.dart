import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/loading_btn.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/validator/validator.dart';
import '../../../../../../core/common_widgets/app_form_field.dart';
import '../../../../../../core/common_widgets/custom_card.dart';
import '../../../../../../core/common_widgets/custom_elevated_button.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/font_manager.dart';
import '../../../../../../core/theme/font_style.dart';
import '../../../../api/models/request/medicine_request.dart';
import '../../../view_model/medicine/medicine_bloc.dart';
import '../../../view_model/medicine/medicine_event.dart';
import '../../../view_model/medicine/medicine_state.dart';
import 'end_date.dart';
import 'medicine_type.dart';
import 'start_date.dart';
import 'time_section.dart';

class AddMedicineCard extends StatefulWidget {
  final String elderId;
  const AddMedicineCard({super.key, required this.elderId});

  @override
  State<AddMedicineCard> createState() => _AddMedicineCardState();
}

class _AddMedicineCardState extends State<AddMedicineCard> {
  final _medicineNameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedType;

  static const List<String> _typeKeys = [
    'tablet',
    'capsule',
    'syrup',
    'injection',
    'drops',
    'cream',
    'inhaler',
    'patch',
  ];

  static const Map<String, String> _typeUnits = {
    'tablet':    'e.g. 1 tablet',
    'capsule':   'e.g. 1 capsule',
    'syrup':     'e.g. 5ml',
    'injection': 'e.g. 1ml',
    'drops':     'e.g. 2 drops',
    'cream':     'e.g. 2g',
    'inhaler':   'e.g. 1 puff',
    'patch':     'e.g. 1 patch',
  };

  static List<String> get _types => _typeKeys.map((k) => k.tr()).toList();

  String get _dosageHint {
    if (_selectedType == null) return 'e.g. 500mg';
    final index = _types.indexOf(_selectedType!);
    if (index == -1) return 'e.g. 500mg';
    return _typeUnits[_typeKeys[index]] ?? 'e.g. 500mg';
  }

  @override
  void dispose() {
    _medicineNameController.dispose();
    _dosageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context, MedicinesState state) {
    final name = _medicineNameController.text.trim();
    final dosage = _dosageController.text.trim();

    if (name.isEmpty || dosage.isEmpty || _selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('pleaseFillInNameDosageAndType'.tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (state.times == null || state.times!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('pleaseAddAtLeastOneReminderTime'.tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final fmt = DateFormat('yyyy-MM-dd');

    final medicine = MedicineRequest(
      elderId: widget.elderId,
      medicineName: name,
      dosage: dosage,
      medicineType: _selectedType!,
      times: state.times,
      startDate: fmt.format(state.startDate),
      endDate: fmt.format(state.effectiveEndDate),
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      state: 'pending',
    );

    context.read<MedicinesBloc>().add(AddMedicineEvent(medicine));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicinesBloc, MedicinesState>(
      listenWhen: (prev, curr) =>
      prev.addMedicineState != curr.addMedicineState,
      listener: (context, state) {
        if (state.addMedicineState.isSuccess) {
          _medicineNameController.clear();
          _dosageController.clear();
          _notesController.clear();
          setState(() => _selectedType = null);
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: context.setHeight(20),
            horizontal: context.setWidth(16),
          ),
          child: CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                AppFormField(
                  label: 'medicineName'.tr(),
                  controller: _medicineNameController,
                  hint: 'e.g. Paracetamol',
                  validator: (val) => Validator.validateRequired(val),
                ),

                Text(
                  'medicineType'.tr(),
                  style: getBoldStyle(
                    color: AppColors.black,
                    fontSize: context.setSp(FontSize.s16),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.setHeight(15),
                  ),
                  child: MedicineTypePicker(
                    selectedType: _selectedType,
                    types: _types,
                    onSelected: (type) {
                      setState(() {
                        _selectedType = type;
                      });
                    },
                  ),
                ),

                AppFormField(
                  label: 'dosage'.tr(),
                  controller: _dosageController,
                  hint: _dosageHint,
                  validator: (val) => Validator.validateRequired(val),
                ),

                SizedBox(height: context.setHeight(12)),

                TimesSection(times: state.times ?? []),

                SizedBox(height: context.setHeight(12)),

                StartDateField(startDate: state.startDate),

                SizedBox(height: context.setHeight(12)),

                EndDateField(state: state, startDate: state.startDate),

                SizedBox(height: context.setHeight(12)),

                AppFormField(
                  label: 'notes(optional)'.tr(),
                  controller: _notesController,
                ),

                SizedBox(height: context.setHeight(20)),

                if (state.addMedicineState.isLoading)
                  const LoadingBtn()
                else
                  CustomElevatedButton(
                    width: context.setWidth(300),
                    onPressed: () => _submit(context, state),
                    buttonLabel: 'addMedicine'.tr(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}