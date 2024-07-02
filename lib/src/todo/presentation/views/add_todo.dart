import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/commons/views/utils/app_utils.dart';
import 'package:pridera_assesment_task/core/commons/views/widgets/app_text_field_widget.dart';
import 'package:pridera_assesment_task/core/commons/views/widgets/global_app_bar.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todolist_model.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_list/create_todo_list.dart';
import 'package:pridera_assesment_task/src/todo/presentation/TodoListCubit/todo_list_cubit.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoListCubit, TodoListState>(
      listener: (_, state) {
        if (state is TodoListError) {
          if(loading) {
            loading = false;
            Navigator.pop(context);
          }
          AppUtils.showSnackBar(context, state.errorMessage);
        } else if (state is CreatingTodoList) {
          loading = true;
          AppUtils.showActionButton(context);
        } else if (state is TodoListCreated) {
          if (loading) {
            loading = false;
            Navigator.pop(context);
          }
          AppUtils.showSnackBar(context, 'Todo Profile Created');
          Navigator.pop(context);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          await context.read<TodoListCubit>().getTodoLists();
          return true;
        },
        child: Scaffold(
          appBar: GlobalAppBar(titleText: ''),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                AppTextFieldWidgets(
                  controller: titleController,
                  filled: false,
                  obscureText: false,
                  readOnly: false,
                  keyboardType: TextInputType.text,
                  overrideValidator: false,
                  hintText: 'Create Profile',
                  hintStyle: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightTitle,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      final todoList = const TodoListModel.empty().copyWith(
                        title: titleController.text.trim(),
                      );
                      final todoParams = CreateTodoListParams(
                        todoList: todoList,
                      );
                      context.read<TodoListCubit>().createTodoList(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
