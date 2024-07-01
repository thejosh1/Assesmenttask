import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';

class TextFieldWidgets extends StatelessWidget {
  const TextFieldWidgets({
    required this.controller,
    required this.filled,
    required this.obscureText,
    required this.readOnly,
    required this.keyboardType,
    required this.overrideValidator,
    super.key,
    this.validator,
    this.fillColor,
    this.suffixIcon,
    this.hintText,
    this.hintStyle,
  });
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool filled;
  final Color? fillColor;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType keyboardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: overrideValidator ? validator : (value) {
        if(value == null || value.isEmpty) {
          return 'This Field is required';
        }
        return validator?.call(value);
      },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.textColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.baseGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        filled: filled,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle ?? TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.baseGrey,
        ),
      ),
    );
  }
}
