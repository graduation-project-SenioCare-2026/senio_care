import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_state.dart';

class CaregiversEditSection extends StatefulWidget {
  final dynamic elder;

  const CaregiversEditSection({super.key, required this.elder});

  @override
  State<CaregiversEditSection> createState() => _CaregiversEditSectionState();
}

class _CaregiversEditSectionState extends State<CaregiversEditSection> {
  final TextEditingController _caregiverIdController = TextEditingController();
  bool _isAddingCaregiver = false;

  @override
  void initState() {
    super.initState();
    final caregiverIds = widget.elder?.caregiverIds ?? [];
    if (caregiverIds.isNotEmpty) {
      context.read<ElderProfileBloc>().add(
        GetMultipleCaregiversEvent(caregiverIds),
      );
    }
  }

  @override
  void dispose() {
    _caregiverIdController.dispose();
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
    return BlocConsumer<ElderProfileBloc, ElderProfileState>(
      listenWhen: (prev, curr) {
        // استمع للتغييرات فقط عند الإضافة أو الحذف
        if (_isAddingCaregiver) {
          return prev.getCaregiversStatus != curr.getCaregiversStatus;
        }
        return false;
      },
      listener: (context, state) {
        if (_isAddingCaregiver) {
          if (state.getCaregiversStatus?.isSuccess ?? false) {
            _showSuccessMessage("caregiverAddedSuccessfully".tr());
            _isAddingCaregiver = false;
          } else if (state.getCaregiversStatus?.isFailure ?? false) {
            final error = state.getCaregiversStatus?.error?.message ??
                "failedToAddCaregiver".tr();
            _showErrorMessage(error);
            _isAddingCaregiver = false;
          }
        }
      },
      buildWhen: (prev, curr) =>
      prev.getCaregiversStatus != curr.getCaregiversStatus,
      builder: (context, state) {
        final caregivers = state.getCaregiversStatus?.data ?? [];
        final isLoading = state.getCaregiversStatus?.isLoading ?? false;
        final hasError = state.getCaregiversStatus?.isFailure ?? false;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "caregivers".tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
            SizedBox(height: context.setHeight(8)),

            /// حالة التحميل
            if (isLoading)
              const Center(child: CircularProgressIndicator()),

            /// حالة الفشل (للتحميل الأولي فقط)
            if (hasError && !_isAddingCaregiver)
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.setHeight(8)),
                child: Text(
                  "errorLoadingCaregivers".tr(),
                  style: TextStyle(color: AppColors.red),
                ),
              ),

            /// عرض الـ caregivers
            if (!isLoading && caregivers.isNotEmpty)
              Column(
                children: caregivers.asMap().entries.map((entry) {
                  final caregiver = entry.value;
                  final index = entry.key;

                  return Padding(
                    padding: EdgeInsets.only(bottom: context.setHeight(8)),
                    child: Container(
                      padding: EdgeInsets.all(context.setMinSize(8)),
                      decoration: BoxDecoration(
                        color: AppColors.blue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.gray[300] ?? Colors.grey[300]!,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.blue.withAlpha(80),
                                radius: context.setMinSize(18),
                                child: Text(
                                  "${index + 1}",
                                  style: getRegularStyle(
                                    color: AppColors.blue,
                                    fontSize: FontSize.s14,
                                  ),
                                ),
                              ),
                              SizedBox(width: context.setWidth(12)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // عرض العلاقة
                                  if ((caregiver.relationship ?? "").isNotEmpty)
                                    Text(
                                      caregiver.relationship ?? "",
                                      style: getRegularStyle(
                                        color: AppColors.gray[600] ??
                                            AppColors.gray,
                                        fontSize: FontSize.s13,
                                      ),
                                    ),
                                  // عرض رقم الهاتف
                                  if ((caregiver.phoneNumber ?? "").isNotEmpty)
                                    Text(
                                      caregiver.phoneNumber ?? "",
                                      style: getRegularStyle(
                                        color: AppColors.gray[500] ??
                                            AppColors.gray,
                                        fontSize: FontSize.s12,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              // تأكيد قبل الحذف
                              _showDeleteConfirmation(caregiver);
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color: AppColors.red,
                              size: context.setMinSize(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

            /// رسالة عند عدم وجود caregivers
            if (!isLoading && caregivers.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.setHeight(16)),
                child: Center(
                  child: Text(
                    "noCaregiversYet".tr(),
                    style: getRegularStyle(
                      color: AppColors.gray[600] ?? AppColors.gray,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
              ),

            SizedBox(height: context.setHeight(16)),

            /// إدخال caregiver جديد
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _caregiverIdController,
                    enabled: !isLoading,
                    decoration: InputDecoration(
                      hintText: "enterCaregiverId".tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.setWidth(12),
                        vertical: context.setHeight(12),
                      ),
                      prefixIcon: Icon(
                        Icons.person_add,
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: context.setWidth(8)),
                ElevatedButton(
                  onPressed: isLoading ? null : () {
                    final id = _caregiverIdController.text.trim();
                    if (id.isEmpty) {
                      _showErrorMessage("pleaseEnterCaregiverId".tr());
                      return;
                    }

                    // تعيين flag للإضافة
                    setState(() {
                      _isAddingCaregiver = true;
                    });

                    context.read<ElderProfileBloc>().add(
                      AddCaregiverEvent(id),
                    );
                    _caregiverIdController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.setWidth(20),
                      vertical: context.setHeight(12),
                    ),
                  ),
                  child: Text("add".tr()),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(CaregiverEntity caregiver) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text("confirmDelete".tr()),
        content: Text(
          "areYouSureDeleteCaregiver".tr(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text("cancel".tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<ElderProfileBloc>().add(
                RemoveCaregiverEvent(caregiver.id!),
              );
              _showSuccessMessage("caregiverRemovedSuccessfully".tr());
            },
            child: Text(
              "delete".tr(),
              style: TextStyle(color: AppColors.red),
            ),
          ),
        ],
      ),
    );
  }
}