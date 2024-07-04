import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/commons/views/widgets/button.dart';
import 'package:pridera_assesment_task/core/extensions/context_extensions.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/core/res/media_res.dart';
import 'package:pridera_assesment_task/core/utility/app_routes.dart';
import 'package:pridera_assesment_task/src/onboarding/presentation/cubit/onboarding_cubit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingStatus && !state.isFirstTimer) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is UserCached) {
            AppRoute.go(AppRoute.init);
          }
        },
        builder: (context, state) {
          if (state is CheckingIfUserIsFirstTimer ||
              state is CachingFirstTimer) {
            return const CircularProgressIndicator(
              color: Colors.white,
            );
          }
          return Column(
            children: [
              Container(
                width: 280.w,
                height: 280.h,
                margin: EdgeInsets.only(top: context.height / 6, left: 40.w),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(MediaRes.onboardingImg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Text(
                  'Jot Down anything you want to achieve, today or in the '
                      'future',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 154.h,
              ),
              GestureDetector(
                onTap: () {
                  context.read<OnboardingCubit>().cacheFirstTimer();
                },
                child: const KButton(
                  color: Colors.white,
                  title: "Let's Get Started",
                  textColor: AppColors.primaryColor,
                  icon: MediaRes.arrowForward,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
