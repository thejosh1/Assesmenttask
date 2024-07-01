import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pridera_assesment_task/core/commons/app/todo_provider.dart';
import 'package:pridera_assesment_task/core/commons/views/utils/app_utils.dart';
import 'package:pridera_assesment_task/core/commons/views/widgets/global_app_bar.dart';
import 'package:pridera_assesment_task/core/extensions/context_extensions.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/core/res/media_res.dart';
import 'package:pridera_assesment_task/core/services/injection_container/injector_container.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todo_model.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/delete_todo.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/update_todo.dart';
import 'package:pridera_assesment_task/src/todo/presentation/TodoCubit/todo_cubit.dart';

import 'package:pridera_assesment_task/src/todo/presentation/views/add_todo_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({required this.title, required this.listId, super.key});

  final String title;
  final String listId;

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TodoCubit>().getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state is TodoError) {
          AppUtils.showSnackBar(context, state.errorMessage);
        } else if (state is TodoUpdated) {
          AppUtils.showSnackBar(context, 'Todo Updated');
        } else if (state is TodoDeleted) {
          AppUtils.showSnackBar(context, 'Todo Deleted');
        }
      },
      child: Scaffold(
        appBar: GlobalAppBar(titleText: ''),
        body: Padding(
          padding: EdgeInsets.only(left: 16.sp, top: 24.h, right: 28.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 32.sp,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(height: 16.h),
              BlocBuilder<TodoCubit, TodoState>(
                builder: (context, state) {
                  if (state is LoadingTodos) {
                    return Center(
                      child: Lottie.asset(MediaRes.loadingAnimation1),);
                  } else if (state is TodoLoaded) {
                    final todoItems = state.todos
                        .where((todo) => todo.listId == widget.listId)
                        .toList();
                    return _buildTodoList(
                      context,
                      todoItems as List<TodoModel>,
                    );
                  } else  if(state is TodoLoaded && state.todos.isEmpty){
                    return const Center(
                      child: Text('No Todo Yet please add a todo'),
                    );
                  }
                  return Center(
                    child: Lottie.asset(MediaRes.loadingAnimation1),);
                },
              ),
              SizedBox(height: 24.h),
              _buildAddTodoButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTodoList(BuildContext context, List<TodoModel> todoItems) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: todoItems.length,
      itemBuilder: (_, index) {
        final item = todoItems[index];
        return Column(
          children: [
            Row(
              children: [
                _buildCheckbox(context, item),
                SizedBox(width: 10.w),
                _buildTodoText(item),
                const Spacer(),
                _buildDeleteButton(context, item),
              ],
            ),
            SizedBox(height: 10.h),
            SizedBox(height: 24.h),
          ],
        );
      },
    );
  }

  Widget _buildCheckbox(BuildContext context, TodoModel item) {
    return GestureDetector(
      onTap: () {
        final todo = item.copyWith(isCompleted: !item.isCompleted);
        final updateTodoParams = UpdateTodoUsecaseParams(
          todoId: todo.id,
          todoItem: todo,
          isCompleted: todo.isCompleted,
        );
        context.read<TodoCubit>().updateTodo(updateTodoParams);
      },
      child: Container(
        width: 22.w,
        height: 22.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.textColor),
          borderRadius: BorderRadius.circular(4.r),
          color: item.isCompleted ? AppColors.primaryColor : null,
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
    );
  }

  Widget _buildTodoText(TodoItem item) {
    return Text(
      item.title.capitalize(),
      style: TextStyle(
        decoration: item.isCompleted ? TextDecoration.lineThrough : null,
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        color: AppColors.textColor,
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context, TodoItem item) {
    return GestureDetector(
      onTap: () {
        final deleteTodoParam = DeleteTodoUseCaseParams(
          listId: item.listId,
          itemId: item.id,
        );
        context.read<TodoCubit>().deleteTodos(deleteTodoParam);
      },
      child: Image.asset(
        MediaRes.deleteIcon,
        fit: BoxFit.cover,
        width: 16.w,
        height: 16.h,
      ),
    );
  }

  Widget _buildAddTodoButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
              create: (_) => sl<TodoCubit>(),
              child: AddTodoItem(listId: widget.listId),
            ),
          ),
        );
      },
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          children: [
            Icon(
              Icons.add,
              size: 20.sp,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: 8.w),
            Text(
              'Add main task',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                decoration: TextDecoration.underline,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
