import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pridera_assesment_task/src/onboarding/domain/usecase/cache_first_time_user.dart';
import 'package:pridera_assesment_task/src/onboarding/domain/usecase/check_if_user_is_firstimer.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required CacheFirstTimeUser cacheFirstTimeUser,
    required CheckIfUserIsFirstTimer checkIfUserIsFirstTimer,
  })  : _cacheFirstTimeUser = cacheFirstTimeUser,
        _checkIfUserIsFirstTimer = checkIfUserIsFirstTimer,
        super(const OnboardingInitial());

  final CacheFirstTimeUser _cacheFirstTimeUser;
  final CheckIfUserIsFirstTimer _checkIfUserIsFirstTimer;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());
    final result = await _cacheFirstTimeUser();
    result.fold(
          (failure) => emit(OnboardingError(failure.errorMessage)),
          (_) => emit(
        const UserCached(),
      ),
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckingIfUserIsFirstTimer());
    final result = await _checkIfUserIsFirstTimer();
    result.fold((failure) => emit(const OnboardingStatus(isFirstTimer: true)),
          (status) => emit(OnboardingStatus(isFirstTimer: status)),);
  }
}
