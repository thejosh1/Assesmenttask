import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/core/res/media_res.dart';

class HomeViewWithoutData extends StatelessWidget {
  const HomeViewWithoutData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 240.w,
            height: 240.h,
            margin: EdgeInsets.only(left: 60.w, right: 60.w),
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    MediaRes.homeViewImage,
                  ),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            height: 24.h,
          ),
          Text(
            'Start Your Journey',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            'Every big step start with small step.'
                '\nNotes your first idea and start'
                '\nyour journey!',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.darkGrey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 21.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 105.w),
            child: Row(
              children: [
                const Spacer(),
                Image.asset(
                  MediaRes.styledArrow,
                  fit: BoxFit.contain,
                  height: 100.h,
                  width: 32.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
