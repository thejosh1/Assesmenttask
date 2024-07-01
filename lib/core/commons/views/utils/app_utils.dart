import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/core/res/media_res.dart';

class AppUtils {
  AppUtils._();

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }

  static void showActionButton(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Lottie.asset(MediaRes.loadingAnimation1),
      ),
    );
  }

  static void showDialogueButton(BuildContext context, VoidCallback onTap,) {
    showDialog<void>(
      context: context,
      builder: (_) => Center(
        child: Container(
          width: 280.w,
          height: 230.h,
          padding: EdgeInsets.only(
            left: 24.w,
            top: 32.h,
            right: 24.w,
            bottom: 32.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                'Are you sure you want to log out\nfrom the application?',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: AppColors.darkGrey,
                ),
              ),
              SizedBox(
                height: 48.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 108.w,
                      height: 38.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                        color: Colors.white
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      width: 108.w,
                      height: 38.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                        color: AppColors.primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
