import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/commons/views/utils/app_utils.dart';
import 'package:pridera_assesment_task/core/commons/views/widgets/app_text_field_widget.dart';
import 'package:pridera_assesment_task/core/commons/views/widgets/global_app_bar.dart';
import 'package:pridera_assesment_task/core/extensions/context_extensions.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todo_model.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/create_todo_item.dart';
import 'package:pridera_assesment_task/src/todo/presentation/TodoCubit/todo_cubit.dart';

class AddTodoItem extends StatefulWidget {
  const AddTodoItem({required this.listId, super.key});
  final String listId;

  @override
  State<AddTodoItem> createState() => _AddTodoItemState();
}

class _AddTodoItemState extends State<AddTodoItem> {
  final todoController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoCubit, TodoState>(
      listener: (_, state) {
        if (state is TodoError) {
          if(loading) {
            loading = false;
            Navigator.pop(context);
          }
          AppUtils.showSnackBar(context, state.errorMessage);
        } else if (state is CreatingTodo) {
          loading = true;
          AppUtils.showActionButton(context);
        } else if (state is TodoCreated) {
          if (loading) {
            loading = false;
            Navigator.pop(context);
          }
          AppUtils.showSnackBar(context, 'Todo Created');
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: GlobalAppBar(),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              AppTextFieldWidgets(
                controller: todoController,
                filled: false,
                obscureText: false,
                readOnly: false,
                keyboardType: TextInputType.text,
                overrideValidator: false,
                hintText: 'Add Todo',
                hintStyle: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightTitle,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    final todoItem = const TodoModel.empty().copyWith(
                      title: todoController.text.trim(),
                      listId: widget.listId,
                      isCompleted: false,
                    );
                    final todoParams = CreateTodoUsecaseParams(
                      todoItem: todoItem,
                    );
                    context.read<TodoCubit>().createTodo(
                      todoParams,
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 20.sp,
                          color: AppColors.lightText,
                        ),
                        SizedBox(
                          width: 13.w,
                        ),
                        Text(
                          'Add main task',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            decoration: TextDecoration.underline,
                            color: AppColors.lightText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
