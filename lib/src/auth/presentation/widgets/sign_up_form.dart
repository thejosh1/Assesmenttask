import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/src/auth/presentation/widgets/textFields.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.emailController,
    required this.fullNameController,
    required this.passwordController,
    required this.retypePasswordController,
    required this.formKey,
    super.key,
  });
  final TextEditingController emailController;
  final TextEditingController fullNameController;
  final TextEditingController passwordController;
  final TextEditingController retypePasswordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Full Name',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          TextFieldWidgets(
            controller: widget.fullNameController,
            filled: true,
            obscureText: false,
            readOnly: false,
            keyboardType: TextInputType.name,
            overrideValidator: false,
            hintText: 'Example: John Doe',
            fillColor: Colors.white,
          ),
          SizedBox(
            height: 32.h,
          ),
          Text(
            'Email Address',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          TextFieldWidgets(
            controller: widget.emailController,
            filled: true,
            obscureText: false,
            readOnly: false,
            keyboardType: TextInputType.emailAddress,
            overrideValidator: false,
            hintText: 'Example: johndoe@gmail.com',
            fillColor: Colors.white,
          ),
          SizedBox(
            height: 32.h,
          ),
          Text(
            'Password',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          TextFieldWidgets(
            controller: widget.passwordController,
            filled: true,
            obscureText: true,
            readOnly: false,
            keyboardType: TextInputType.visiblePassword,
            overrideValidator: false,
            hintText: '********',
            fillColor: Colors.white,
            // suffixIcon: IconButton(
            //   onPressed: () => setState(() {
            //     obscurePassword = !obscurePassword;
            //   }),
            //   icon: Icon(
            //     obscurePassword ? IconlyLight.show : IconlyLight.hide,
            //     color: Colors.grey,
            //   ),
            // ),
          ),
          SizedBox(
            height: 32.h,
          ),
          Text(
            'Retype Password',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          TextFieldWidgets(
            controller: widget.retypePasswordController,
            filled: true,
            obscureText: true,
            readOnly: false,
            keyboardType: TextInputType.visiblePassword,
            overrideValidator: true,
            hintText: '********',
            fillColor: Colors.white,
            validator: (value) {
              if(value != widget.passwordController.text) {
                return 'Passwords do not match';
              } return null;
            },
            // suffixIcon: IconButton(
            //   onPressed: () => setState(() {
            //     obscurePassword = !obscurePassword;
            //   }),
            //   icon: Icon(
            //     obscurePassword ? IconlyLight.show : IconlyLight.hide,
            //     color: Colors.grey,
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
