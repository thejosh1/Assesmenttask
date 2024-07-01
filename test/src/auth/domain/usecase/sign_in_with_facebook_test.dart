import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/src/auth/domain/entities/user.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/sign_in_with_facebook_usecase.dart';

import 'auth_repo.mock.test.dart';

void main() {
  late MockAuthRepo repo;
  late FacebookSignIn usecase;

  setUp(() {
    repo = MockAuthRepo();
    usecase = FacebookSignIn(repo);
  });

  const tLocalUser = LocalUser.empty();
  test('should return [localUser', () async {
    //arrange
    when(() => repo.signInWithFacebook())
        .thenAnswer((_) async => const Right(tLocalUser));

    final result = await usecase();

    expect(result, equals(const Right<dynamic, LocalUser>(tLocalUser)));
    verify(() => repo.signInWithFacebook()).called(1);
    verifyNoMoreInteractions(repo);
  });
}