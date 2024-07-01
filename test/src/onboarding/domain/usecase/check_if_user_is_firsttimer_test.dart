import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/src/onboarding/domain/repo/onboarding_repo.dart';
import 'package:pridera_assesment_task/src/onboarding/domain/usecase/check_if_user_is_firstimer.dart';

import 'onboarding_repo.mock.dart';

void main() {
  late OnboardingRepo repo;
  late CheckIfUserIsFirstTimer usecase;

  setUp(() {
    repo = MockOnboardingRepo();
    usecase = CheckIfUserIsFirstTimer(repo);
  });

  test('should get a response from [OnboardingRepo.checkIfUserIsFirstTimer]',
          () async {
        //arrange
        when(() => repo.checkIfUserIsFirstTimer()).thenAnswer(
              (_) async => const Right(true),
        );
        //act
        final result = await usecase();
        //assert
        expect(result, equals(const Right<dynamic, bool>(true)));
        verify(() => repo.checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(repo);
      });
}
