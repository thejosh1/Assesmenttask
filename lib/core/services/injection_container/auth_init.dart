part of 'injector_container.dart';

Future<void> authInit() async {
  sl
    ..registerFactory(
          () => AuthBloc(
              signIn: sl(),
              signUp: sl(),
            googleSignIn: sl(),
            forgotPassword: sl(),

      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => SignInWithGoogleAuth(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(
        authClient: sl(),
        googleSignIn: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )
    ..registerLazySingleton(GoogleSignIn.new)
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}
