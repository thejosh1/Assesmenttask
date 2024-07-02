import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pridera_assesment_task/core/commons/app/tab_navigator.dart';
import 'package:pridera_assesment_task/core/commons/views/utils/persistent_views.dart';
import 'package:pridera_assesment_task/core/services/injection_container/injector_container.dart';
import 'package:pridera_assesment_task/src/auth/presentation/auth/auth_bloc.dart';
import 'package:pridera_assesment_task/src/home/presentation/views/home_view.dart';
import 'package:pridera_assesment_task/src/settings/presentation/views/settings_page.dart';
import 'package:pridera_assesment_task/src/todo/presentation/TodoCubit/todo_cubit.dart';
import 'package:pridera_assesment_task/src/todo/presentation/TodoListCubit/todo_list_cubit.dart';
import 'package:provider/provider.dart';

class MainPageController extends ChangeNotifier {
  List<int> _indexHistory = [0];
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<TodoListCubit>()),
              BlocProvider(create: (_) => sl<TodoCubit>()),
            ],
            child: const HomeView(),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const SettingsPage(),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
  ];

  List<Widget> get screens => _screens;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}
