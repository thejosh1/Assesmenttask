import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';

class GridCard extends StatelessWidget {
  const GridCard({
    required this.title,
    required this.todoItemName,
    required this.isCompleted,
    super.key,
  });
  final String title;
  final List<TodoItem> todoItemName;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156.w,
      height: 252.h,
      padding: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: 20.sp,
                  color: AppColors.lightTitle,
                ),
                SizedBox(
                  width: 5.w,
                ),
                SizedBox(
                  width: 60.w,
                  height: 50,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (todoItemName.isNotEmpty)
            SizedBox(
              height: 150.h,
              child: ListView.builder(
                  itemCount: todoItemName.length,
                  itemBuilder: (context, index) {
                    final item = todoItemName[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 12.w,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 11.w,
                                height: 11.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  border:
                                      Border.all(color: AppColors.textColor),
                                  color: item.isCompleted
                                      ? AppColors.primaryColor
                                      : null,
                                ),
                                child: item.isCompleted
                                    ? Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 10.sp,
                                        ),
                                      )
                                    : null,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                item.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    );
                  },),
            )
          else
            const Center(
              child: Text('Please add a todo'),
            ),
          const Spacer(),
          Container(
            width: double.maxFinite,
            height: 28.h,
            padding: EdgeInsets.only(left: 12.sp, top: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
              color: AppColors.primaryColor,
            ),
            child: Text(
              'Task',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
