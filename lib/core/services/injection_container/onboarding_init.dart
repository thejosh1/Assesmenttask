part of 'injector_container.dart';

Future<void> onboardingInit() async {
  final prefs = await SharedPreferences.getInstance();
  sl..registerLazySingleton(NavigatorService.new)
    ..registerFactory(
          () => OnboardingCubit(
        cacheFirstTimeUser: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTimeUser(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
    ..registerLazySingleton<OnboardingRepo>(
          () => OnboardingRepoImplementation(sl()),
    )
    ..registerLazySingleton<OnboardingLocalDataSource>(
          () => OnboardingLocalDataSrcImpl(sl()),
    )
    ..registerLazySingleton(() => prefs);
}
