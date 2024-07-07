import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pridera_assesment_task/core/services/navigator_service.dart';
import 'package:pridera_assesment_task/src/auth/data/datasource/remote_data_source.dart';
import 'package:pridera_assesment_task/src/auth/data/repo/auth_repo_implementation.dart';
import 'package:pridera_assesment_task/src/auth/domain/repo/auth_repo.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/sign_in_usecase.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/sign_in_with_facebook_usecase.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/sign_in_with_google_usecase.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/sign_up_usecase.dart';
import 'package:pridera_assesment_task/src/auth/presentation/auth/auth_bloc.dart';
import 'package:pridera_assesment_task/src/onboarding/data/datasource/onboarding_local_datasource.dart';
import 'package:pridera_assesment_task/src/onboarding/data/onboarding_repo_implementation.dart';
import 'package:pridera_assesment_task/src/onboarding/domain/repo/onboarding_repo.dart';
import 'package:pridera_assesment_task/src/onboarding/domain/usecase/cache_first_time_user.dart';
import 'package:pridera_assesment_task/src/onboarding/domain/usecase/check_if_user_is_firstimer.dart';
import 'package:pridera_assesment_task/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:pridera_assesment_task/src/todo/data/datasources/todo_list_remote_datasource.dart';
import 'package:pridera_assesment_task/src/todo/data/datasources/todo_remote_datasource.dart';
import 'package:pridera_assesment_task/src/todo/data/repo/todo_list_repo_impl.dart';
import 'package:pridera_assesment_task/src/todo/data/repo/todo_repo_impl.dart';
import 'package:pridera_assesment_task/src/todo/domain/repo/todo_items.dart';
import 'package:pridera_assesment_task/src/todo/domain/repo/todo_list_repo.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/create_todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/delete_todo.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/get_all_todos.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/update_todo.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_list/create_todo_list.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_list/get_all_todo_lists.dart';
import 'package:pridera_assesment_task/src/todo/presentation/TodoCubit/todo_cubit.dart';
import 'package:pridera_assesment_task/src/todo/presentation/TodoListCubit/todo_list_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_init.dart';
part 'onboarding_init.dart';
part 'todoList_init.dart';
part 'todo_init.dart';

GetIt sl = GetIt.instance;

// register your models here

Future<void> init() async {
  log('starting initialization');
    await onboardingInit();
    await authInit();
    await todoListInit();
    await todoInit();
  log('finished initialization');
}