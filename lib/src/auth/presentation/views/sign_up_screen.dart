import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pridera_assesment_task/core/commons/app/user_provider.dart';
import 'package:pridera_assesment_task/core/commons/views/utils/app_utils.dart';
import 'package:pridera_assesment_task/core/commons/views/widgets/button.dart';
import 'package:pridera_assesment_task/core/extensions/context_extensions.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/core/res/media_res.dart';
import 'package:pridera_assesment_task/core/utility/app_routes.dart';
import 'package:pridera_assesment_task/src/auth/data/model/local_user_model.dart';
import 'package:pridera_assesment_task/src/auth/presentation/auth/auth_bloc.dart';
import 'package:pridera_assesment_task/src/auth/presentation/widgets/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            AppUtils.showSnackBar(context, state.errorMessage);
          } else if (state is SignedUp) {
            context.read<AuthBloc>().add(
                  SignInEvent(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ),
                );
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user as LocalUserModel);
            AppRoute.go(AppRoute.home);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                top: context.height / 8,
                left: 16.w,
                right: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        size: 16.sp,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Back to Login',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    'And start taking notes',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  SignUpForm(
                    emailController: emailController,
                    passwordController: passwordController,
                    formKey: formKey,
                    fullNameController: fullNameController,
                    retypePasswordController: confirmPasswordController,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  if (state is AuthLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        FirebaseAuth.instance.currentUser?.reload();
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                SignUpEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  fullName: passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                      child: const kButton(
                        color: AppColors.primaryColor,
                        title: 'Register',
                        textColor: Colors.white,
                        icon: MediaRes.arrowForwardWhite,
                      ),
                    ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Center(
                    child: Text(
                      'Or',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.currentUser?.reload();
                          context.read<AuthBloc>().add(
                                const SignInWithGoogleEvent(),
                              );
                          setState(() {});
                        },
                        child: Container(
                          width: 54.w,
                          height: 54.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: AppColors.baseGrey),
                          ),
                          child: Center(
                            child: Image.asset(
                              MediaRes.googleIcon,
                              width: 29.55,
                              height: 29.55,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 36.w,
                      ),
                      Container(
                        width: 54.w,
                        height: 54.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.baseGrey),
                        ),
                        child: Center(
                          child: Image.asset(
                            MediaRes.facebookIcon,
                            width: 29.55,
                            height: 29.55,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have any account?',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      const SizedBox.shrink(),
                      GestureDetector(
                        onTap: () {
                          AppRoute.go(AppRoute.signIn);
                        },
                        child: Text(
                          ' Login here',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
