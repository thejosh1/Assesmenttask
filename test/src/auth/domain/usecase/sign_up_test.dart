import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/sign_up_usecase.dart';

import 'auth_repo.mock.test.dart';

void main() {
  late MockAuthRepo repo;
  late SignUp usecase;

  const tEmail = 'Test email';
  const tPassword = 'Test password';
  const tFullName = 'Test fullName';

  setUp(() {
    repo = MockAuthRepo();
    usecase = SignUp(repo);
  });

  test('should return [LocalUser] from the [AuthRepo]', () async {
    when(
      () => repo.signUp(
        email: any(named: 'email'),
        fullName: any(named: 'fullName'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(
      const SignUpParams(
          email: tEmail, password: tPassword, fullName: tFullName,),
    );

    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repo.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      ),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
