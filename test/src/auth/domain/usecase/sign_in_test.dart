import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/src/auth/domain/entities/user.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/sign_in_usecase.dart';

import 'auth_repo.mock.test.dart';

void main() {
  late MockAuthRepo repo;
  late SignIn usecase;

  const tEmail = 'Test email';
  const tPassword = 'Test password';

  setUp(() {
    repo = MockAuthRepo();
    usecase = SignIn(repo);
  });

  const tUser = LocalUser.empty();

  test('should return [LocalUser] from the [AuthRepo]', () async {
    when(
      () => repo.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(tUser));

    final result =  await usecase(
      const SignInParams(email: tEmail, password: tPassword),
    );

    expect(result, equals(const Right<dynamic, LocalUser>(tUser)));
    verify(() => repo.signIn(email: tEmail, password: tPassword)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
