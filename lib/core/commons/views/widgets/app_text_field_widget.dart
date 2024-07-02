import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';

class AppTextFieldWidgets extends StatelessWidget {
  const AppTextFieldWidgets({
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
    this.width,
    this.height,
    this.bottomHeight,
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
  final double? width;
  final double? height;
  final double? bottomHeight;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: overrideValidator
          ? validator
          : (value) {
              if (value == null || value.isEmpty) {
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
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: Colors.transparent),
          gapPadding: 0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: Colors.transparent),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.r),
          borderSide: const BorderSide(color: Colors.transparent),
          gapPadding: 0,
        ),
        contentPadding: EdgeInsets.only(
          left: width ?? 16.w,
          top: height ?? 16.h,
          bottom: bottomHeight ?? 0,

        ),
        filled: filled,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle ??
            TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.baseGrey,
            ),
      ),
    );
  }
}
