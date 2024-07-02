import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/extensions/context_extensions.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key, this.titleText});

  final String? titleText;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        try {
          context.pop();
        } catch (_) {
          Navigator.of(context).pop();
        }
        return true;
      },
      child: GestureDetector(
        onTap: () {
          try {
            context.pop();
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
        child: SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              if (Theme.of(context).platform == TargetPlatform.iOS)
                Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.primaryColor,
                  size: 10.sp,
                )
              else
                Icon(
                  Icons.arrow_back,
                  color: AppColors.primaryColor,
                  size: 10.sp,
                ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                'Back',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                width: 90.w,
              ),
              if (titleText!.isNotEmpty)
                Text(
                  titleText!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
