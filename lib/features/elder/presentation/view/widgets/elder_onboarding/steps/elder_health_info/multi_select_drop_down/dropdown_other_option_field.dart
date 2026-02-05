import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class DropdownOtherOptionField extends StatelessWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final String hintText;
  final VoidCallback onAddPressed;

  const DropdownOtherOptionField({
    required this.controller,
    required this.formKey,
    required this.hintText,
    required this.onAddPressed,
    required String? Function(String?)? validator,
    super.key,
  }) : _validator = validator;

  final String? Function(String?)? _validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setWidth(10),
        vertical: context.setHeight(5),
      ),
      child: Form(
        key: formKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: getRegularStyle(
                    color: AppColors.gray[600] ?? AppColors.gray,
                    fontSize: context.setSp(FontSize.s12),
                  ),
                  prefixIcon: Icon(
                    Icons.edit,
                    color: AppColors.blue,
                    size: context.setWidth(20),
                  ),
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: context.setWidth(12),
                    vertical: context.setHeight(10),
                  ),
                  border: _buildBorder(context, AppColors.gray),
                  enabledBorder: _buildBorder(context, AppColors.gray),
                  focusedBorder: _buildBorder(context, AppColors.gradientEnd),
                  errorBorder: _buildBorder(context, AppColors.red),
                ),
                style: getRegularStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s13),
                ),
                validator: _validator,
              ),
            ),
            SizedBox(width: context.setWidth(8)),
            IconButton(
              onPressed: onAddPressed,
              icon: Icon(
                Icons.add_circle,
                color: AppColors.gradientEnd,
                size: context.setWidth(30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static OutlineInputBorder _buildBorder(BuildContext context, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(context.setMinSize(5)),
      borderSide: BorderSide(
        color: color,
        width: context.setWidth(1),
      ),
    );
  }
}