import 'package:pridera_assesment_task/core/usecases/usecase.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/onboarding/domain/repo/onboarding_repo.dart';

class CheckIfUserIsFirstTimer extends UseCaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repo);

  final OnboardingRepo _repo;

  @override
  ResultFuture<bool> call() async => _repo.checkIfUserIsFirstTimer();
}
