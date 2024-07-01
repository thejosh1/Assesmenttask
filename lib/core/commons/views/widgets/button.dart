import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/res/media_res.dart';

class kButton extends StatelessWidget {
  const kButton({
    required this.color,
    required this.title,
    required this.textColor,
    required this.icon,
    super.key,
  });
  final Color color;
  final String title;
  final Color textColor;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 54.h,
      margin: EdgeInsets.only(left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: color,
      ),
      child: Row(
        children: [
          Spacer(),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: textColor,
            ),
          ),
          SizedBox(width: 100.w,),
          Image.asset(icon, fit: BoxFit.cover, height: 20.h,),
          SizedBox(width: 16.w,),
        ],
      ),
    );
  }
}
