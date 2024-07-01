
import 'package:pridera_assesment_task/core/usecases/usecase.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/onboarding/domain/repo/onboarding_repo.dart';

class CacheFirstTimeUser extends UseCaseWithoutParams<void> {
  const CacheFirstTimeUser(this._repo);

  final OnboardingRepo _repo;

  @override
  ResultFuture<void> call() async => _repo.cacheFirstTimeUser();

}