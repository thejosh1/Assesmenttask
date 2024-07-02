import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/services/injection_container/injector_container.dart';


import 'package:pridera_assesment_task/src/home/presentation/views/widgets/grid/grid_card.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_list.dart';
import 'package:pridera_assesment_task/src/todo/presentation/TodoCubit/todo_cubit.dart';
import 'package:pridera_assesment_task/src/todo/presentation/views/todo_screen.dart';

class CardGrid extends StatelessWidget {
  const CardGrid({required this.todoLists, required this.todoModel, super.key});

  final List<TodoList> todoLists;
  final List<TodoItem> todoModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.619,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: todoLists.length,
          itemBuilder: (context, index) {
            final todo = todoLists[index];
            final todoItem =
            todoModel.where((item) => item.listId == todo.id).toList();
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        BlocProvider(
                          create: (context) => sl<TodoCubit>()..getTodos(),
                          child: TodoScreen(
                            title: todo.title,
                            listId: todo.id,
                          ),
                        ),
                  ),
                ).then((_) {
                  // Refresh todos when returning from TodoScreen
                  context.read<TodoCubit>().getTodos();
                });
              },
              child: GridCard(
                title: todo.title,
                todoItemName: todoItem,
                isCompleted: true,
              ),
            );
          },
        ),
      ],
    );
  }
}
