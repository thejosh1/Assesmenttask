import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/src/auth/presentation/widgets/textFields.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        ],
      ),
    );
  }
}
