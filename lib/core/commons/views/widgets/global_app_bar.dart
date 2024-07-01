import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/commons/views/widgets/nested_back_button.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  GlobalAppBar({super.key, this.titleText});
  final String? titleText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: NestedBackButton(titleText: titleText,),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.borderColor,
            height: 1,
          ),
        ),
      ),
    );
  }

  @override
  Size preferredSize = const Size.fromHeight(kToolbarHeight);
}
