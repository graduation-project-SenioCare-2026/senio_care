import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_bloc.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_event.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_state.dart';

class ElderIdsEditSection extends StatefulWidget {
  const ElderIdsEditSection({super.key});

  @override
  State<ElderIdsEditSection> createState() => _ElderIdsEditSectionState();
}

class _ElderIdsEditSectionState extends State<ElderIdsEditSection> {
  final TextEditingController _elderIdController = TextEditingController();
  bool _isAddingElder = false;
  bool _isRemovingElder = false;

  @override
  void dispose() {
    _elderIdController.dispose();
    super.dispose();
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaregiverEditProfileBloc, CaregiverEditProfileState>(
      listenWhen: (prev, curr) => prev.getElderState != curr.getElderState,
      listener: (context, state) {
        if (_isAddingElder) {
          if (state.getElderState.isSuccess) {
            _showSuccessMessage("elderAddedSuccessfully".tr());
            setState(() => _isAddingElder = false);
          } else if (state.getElderState.isFailure) {
            final error =
                state.getElderState.error?.message ?? "failedToAddElder".tr();
            _showErrorMessage(error);
            setState(() => _isAddingElder = false);
          }
        }

        if (_isRemovingElder) {
          if (state.getElderState.isSuccess) {
            _showSuccessMessage("elderRemovedSuccessfully".tr());
            setState(() => _isRemovingElder = false);
          } else if (state.getElderState.isFailure) {
            final error =
                state.getElderState.error?.message ??
                "failedToRemoveElder".tr();
            _showErrorMessage(error);
            setState(() => _isRemovingElder = false);
          }
        }
      },
      buildWhen: (prev, curr) => prev.getElderState != curr.getElderState,
      builder: (context, state) {
        final elders = state.getElderState.data ?? [];
        final isLoading = state.getElderState.isLoading;
        final hasError = state.getElderState.isFailure;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: context.setWidth(8)),
            Text(
              "elders".tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
            SizedBox(height: context.setHeight(12)),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _elderIdController,
                        enabled: !isLoading,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_add,
                            color: AppColors.blue,
                          ),
                          hintText: "enterElderId".tr(),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.gray[300] ?? Colors.grey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.gray[300] ?? Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.blue,
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: context.setWidth(12),
                            vertical: context.setHeight(12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: context.setWidth(8)),
                    GestureDetector(
                      onTap: () {
                        final id = _elderIdController.text.trim();
                        if (id.isEmpty) {
                          _showErrorMessage("pleaseEnterElderId".tr());
                          return;
                        }
                        if (elders.any((e) => e.id == id)) {
                          _showErrorMessage("elderIdAlreadyExists".tr());
                          return;
                        }
                        setState(() => _isAddingElder = true);
                        context.read<CaregiverEditProfileBloc>().add(
                          AddElderId(id),
                        );
                        _elderIdController.clear();
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: context.setMinSize(24),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: context.setHeight(16)),
            if (!isLoading && elders.isNotEmpty)
              Column(
                children: elders.asMap().entries.map((entry) {
                  final elder = entry.value;
                  final index = entry.key;
                  return Padding(
                    padding: EdgeInsets.only(bottom: context.setHeight(8)),
                    child: Container(
                      padding: EdgeInsets.all(context.setMinSize(12)),
                      decoration: BoxDecoration(
                        color: AppColors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.blue.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.blue.withOpacity(0.2),
                            radius: context.setMinSize(20),
                            child: Text(
                              "${index + 1}",
                              style: getBoldStyle(
                                color: AppColors.blue,
                                fontSize: FontSize.s14,
                              ),
                            ),
                          ),
                          SizedBox(width: context.setWidth(12)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  elder.id ?? '',
                                  style: getRegularStyle(
                                    color: AppColors.black,
                                    fontSize: FontSize.s14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() => _isRemovingElder = true);
                              context.read<CaregiverEditProfileBloc>().add(
                                RemoveElderId(elder.id ?? ''),
                              );
                            },
                            child: Container(
                              width: context.setMinSize(28),
                              height: context.setMinSize(28),
                              decoration: BoxDecoration(
                                color: AppColors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: context.setMinSize(16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

            if (!isLoading && elders.isEmpty && !hasError)
              Row(
                children: [
                  SizedBox(width: context.setWidth(12)),
                  Expanded(
                    child: Text(
                      "noEldersYet".tr(),
                      style: getRegularStyle(
                        color: AppColors.gray[600] ?? AppColors.gray,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
