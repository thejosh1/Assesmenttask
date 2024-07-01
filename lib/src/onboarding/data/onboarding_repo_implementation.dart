import 'package:dartz/dartz.dart';
import 'package:pridera_assesment_task/core/errors/exceptions.dart';
import 'package:pridera_assesment_task/core/errors/failures.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/onboarding/data/datasource/onboarding_local_datasource.dart';
import 'package:pridera_assesment_task/src/onboarding/domain/repo/onboarding_repo.dart';

class OnboardingRepoImplementation implements OnboardingRepo {
  const OnboardingRepoImplementation(this._localDataSource);

  final OnboardingLocalDataSource _localDataSource;

  @override
  ResultFuture<void> cacheFirstTimeUser() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch(e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await _localDataSource.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheException catch(e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

}