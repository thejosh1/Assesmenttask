
import 'package:pridera_assesment_task/core/utility/typedef.dart';

abstract class OnboardingRepo {
  const OnboardingRepo();

  ResultFuture<void> cacheFirstTimeUser();
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
