import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';
import '../../../../../../../../core/user/profile_manager.dart';
import 'info_raw.dart';

class ElderIdsSection extends StatefulWidget {
  final List<ElderEntity> elder;
  final bool isLoading;
  final bool hasError;

  const ElderIdsSection({
    super.key,
    required this.elder,
    this.isLoading = false,
    this.hasError = false,
  });

  @override
  State<ElderIdsSection> createState() => _ElderIdsSectionState();
}

class _ElderIdsSectionState extends State<ElderIdsSection> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();

    if (widget.elder.length == 1) {
      _selectedIndex = 0;
      ProfileManager().selectedElder = widget.elder.first;
      return;
    }

    final savedElder = ProfileManager().selectedElder;
    if (savedElder != null) {
      _selectedIndex = widget.elder.indexWhere((e) => e.id == savedElder.id);
      if (_selectedIndex == -1) _selectedIndex = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Padding(
        padding: EdgeInsets.all(context.setWidth(16)),
        child: Column(
          children: [
            SizedBox(height: context.setHeight(8)),
            Text(
              "loadingElders".tr(),
              style: TextStyle(
                fontSize: context.setSp(12),
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (widget.elder.isEmpty) {
      return Column(
        children: [
          InfoRow(
            label: "elders".tr(),
            icon: Icons.elderly,
            value: "noElders".tr(),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.elderly,
              size: context.setWidth(25),
              color: AppColors.gray[600],
            ),
            SizedBox(width: context.setWidth(8)),
            Text(
              "elders".tr(),
              style: getRegularStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
          ],
        ),
        SizedBox(height: context.setHeight(8)),
        Padding(
          padding: EdgeInsetsDirectional.only(start: context.setWidth(25)),
          child: Column(
            children: widget.elder.asMap().entries.map<Widget>((entry) {
              final elderEntity = entry.value;
              final index = entry.key;
              final isSelected = _selectedIndex == index;

              return Padding(
                padding: EdgeInsets.only(bottom: context.setHeight(8)),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.blue.withAlpha(80),
                      radius: context.setMinSize(13),
                      child: Text(
                        "${index + 1}",
                        style: getRegularStyle(
                          color: AppColors.blue,
                          fontSize: FontSize.
                          s12,
                        ),
                      ),
                    ),
                    SizedBox(width: context.setWidth(10)),
                    Expanded(
                      child: Text(
                        elderEntity.id ?? '',
                        style: getRegularStyle(
                          color: AppColors.gray[600] ?? AppColors.gray,
                          fontSize: FontSize.s13,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = isSelected ? null : index;
                        });
                        if (!isSelected) {
                          ProfileManager().selectedElder = elderEntity;
                        } else {
                          ProfileManager().selectedElder = null;
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.all(context.setWidth(6)),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? AppColors.blue : Colors.transparent,
                          border: Border.all(
                            color: AppColors.blue,
                            width: 1.2,
                          ),
                        ),
                        child: isSelected
                            ? Icon(
                          Icons.check,
                          size: context.setSp(12),
                          color: AppColors.white,
                        )
                            : SizedBox(
                          width: context.setSp(12),
                          height: context.setSp(12),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}