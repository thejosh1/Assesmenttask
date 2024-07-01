part of 'injector_container.dart';

Future<void> todoInit() async {
  sl
    ..registerFactory(() => TodoCubit(
        createTodo: sl(), getTodos: sl(), deleteTodo: sl(), updateTodo: sl()))
    ..registerLazySingleton(() => CreateTodoUsecase(sl()))
    ..registerLazySingleton(() => GetAllTodosUsecase(sl()))
    ..registerLazySingleton(() => DeleteTodoUseCase(sl()))
    ..registerLazySingleton(() => UpdateTodoUsecase(sl()))
    ..registerLazySingleton<TodoItemRepo>(() => TodoRepoImpl(sl()))
    ..registerLazySingleton<TodoRemoteDataSrc>(
      () => TodoRemoteDataSrcImpl(firestore: sl(), auth: sl()),
    );
}
