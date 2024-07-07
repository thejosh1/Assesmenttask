import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/commons/app/user_provider.dart';
import 'package:pridera_assesment_task/core/commons/views/utils/app_utils.dart';
import 'package:pridera_assesment_task/core/commons/views/widgets/button.dart';
import 'package:pridera_assesment_task/core/extensions/context_extensions.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/core/res/media_res.dart';
import 'package:pridera_assesment_task/core/utility/app_routes.dart';
import 'package:pridera_assesment_task/src/auth/data/model/local_user_model.dart';
import 'package:pridera_assesment_task/src/auth/presentation/auth/auth_bloc.dart';
import 'package:pridera_assesment_task/src/auth/presentation/widgets/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            AppUtils.showSnackBar(context, state.errorMessage);
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
                top: context.height / 7,
                left: 16.w,
                right: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's Login",
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
                    'And note your idea',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  SignInForm(
                    emailController: emailController,
                    passwordController: passwordController,
                    formKey: formKey,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.forgotPassword);
                    },
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
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
                                SignInEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                      child: const KButton(
                        color: AppColors.primaryColor,
                        title: 'Login',
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
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.currentUser?.reload();
                          context.read<AuthBloc>().add(
                            const SignInWithFacebookEvent(),
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
                              MediaRes.facebookIcon,
                              width: 29.55,
                              height: 29.55,
                              fit: BoxFit.cover,
                            ),
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
                      GestureDetector(
                        onTap: () {
                          AppRoute.go(AppRoute.signUp);
                        },
                        child: Text(
                          ' Register here',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
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
