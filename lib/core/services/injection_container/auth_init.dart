part of 'injector_container.dart';

Future<void> authInit() async {
  sl
    ..registerFactory(
          () => AuthBloc(
              signIn: sl(),
              signUp: sl(),
            googleSignIn: sl(),
            facebookSignIn: sl(),
            forgotPassword: sl(),

      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => SignInWithGoogleAuth(sl()))
    ..registerLazySingleton(() => FacebookSignIn(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(
        authClient: sl(),
        googleSignIn: sl(),
        cloudStoreClient: sl(),
      ),
    )
    ..registerLazySingleton(GoogleSignIn.new)
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance);
}
