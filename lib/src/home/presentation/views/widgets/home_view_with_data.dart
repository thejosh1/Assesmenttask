import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pridera_assesment_task/core/commons/views/utils/app_utils.dart';
import 'package:pridera_assesment_task/core/res/colors.dart';
import 'package:pridera_assesment_task/core/res/media_res.dart';

import 'package:pridera_assesment_task/src/home/presentation/views/widgets/grid/grid_view.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_list.dart';
import 'package:pridera_assesment_task/src/todo/presentation/TodoCubit/todo_cubit.dart';

class HomeViewWithData extends StatefulWidget {
  const HomeViewWithData({
    required this.todoList,
    required this.todolistLength,
    super.key,
  });
  final List<TodoList> todoList;
  final String todolistLength;

  @override
  State<HomeViewWithData> createState() => _HomeViewWithDataState();
}

class _HomeViewWithDataState extends State<HomeViewWithData> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshTodos();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshTodos();
    }
  }

  void _refreshTodos() {
    context.read<TodoCubit>().getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (_, state) {
        if (state is TodoError) {
          AppUtils.showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              _refreshTodos();
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeader()),
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                if (state is LoadingTodos)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state is TodoLoaded)
                  SliverToBoxAdapter(
                    child: CardGrid(todoLists: widget.todoList, todoModel: state.todos),
                  )
                else
                  const SliverFillRemaining(
                    child: Center(child: Text('No todos available')),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 160.h,
      width: double.maxFinite,
      color: AppColors.primaryColor,
      padding: EdgeInsets.only(
        left: 16.w,
        top: 45.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amazing Journey!',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'You have successfully\nfinished ${widget.todolistLength} notes',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Image.asset(
            MediaRes.appbarImage,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
