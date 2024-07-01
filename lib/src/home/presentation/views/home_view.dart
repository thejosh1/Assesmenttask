import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pridera_assesment_task/core/commons/views/utils/app_utils.dart';
import 'package:pridera_assesment_task/core/res/media_res.dart';
import 'package:pridera_assesment_task/src/home/presentation/views/widgets/home_view_with_data.dart';
import 'package:pridera_assesment_task/src/home/presentation/views/widgets/home_view_without_data.dart';
import 'package:pridera_assesment_task/src/todo/presentation/TodoListCubit/todo_list_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    _refreshTodoLists();
  }

  void _refreshTodoLists() {
    context.read<TodoListCubit>().getTodoLists();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoListCubit, TodoListState>(
      listener: (_, state) {
        if (state is TodoListError) {
          AppUtils.showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is LoadingTodoList) {
          return Center(
            child: Lottie.asset(MediaRes.loadingAnimation1),
          );
        } else if (state is TodoListLoaded && state.todoLists.isEmpty ||
            state is TodoListError) {
          return const HomeViewWithoutData();
        } else if (state is TodoListLoaded) {
          return HomeViewWithData(
            todoList: state.todoLists,
            todolistLength: state.todoLists.length.toString(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
