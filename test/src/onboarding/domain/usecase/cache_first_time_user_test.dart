import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/core/errors/failures.dart';
import 'package:pridera_assesment_task/src/onboarding/domain/repo/onboarding_repo.dart';
import 'package:pridera_assesment_task/src/onboarding/domain/usecase/cache_first_time_user.dart';

import 'onboarding_repo.mock.dart';

void main() {
  late OnboardingRepo repo;
  late CacheFirstTimeUser usecase;

  setUp(() {
    repo = MockOnboardingRepo();
    usecase = CacheFirstTimeUser(repo);
  });

  test(
      'should call the [Onboarding.cacheFirstTimeUser] '
          'and return the right data', () async {
    //arrange
    when(() => repo.cacheFirstTimeUser()).thenAnswer(
          (_) async => left(
        ServerFailure(message: 'failed to cache', statusCode: 500),
      ),
    );

    //act
    final result = await usecase();

    //assert
    expect(
      result,
      equals(
        left<Failure, dynamic>(
          ServerFailure(message: 'failed to cache', statusCode: 500),
        ),
      ),
    );
    verify(() => repo.cacheFirstTimeUser()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
