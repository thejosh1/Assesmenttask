part of 'injector_container.dart';

Future<void> todoListInit() async {
  sl
    ..registerFactory(
      () => TodoListCubit(createTodoList: sl(), getAllTodoList: sl()),
    )
    ..registerLazySingleton(() => CreateTodoListUsecase(sl()))
    ..registerLazySingleton(() => GetAllTodoListsUsecase(sl()))
    ..registerLazySingleton<TodoListRepo>(() => TodoListRepoImpl(sl()))
    ..registerLazySingleton<TodoListRemoteDataSrc>(
      () => TodoListRemoteDataSrcImpl(firestore: sl(), auth: sl()),
    );
}
