import 'package:pridera_assesment_task/core/usecases/usecase.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/auth/domain/entities/user.dart';
import 'package:pridera_assesment_task/src/auth/domain/repo/auth_repo.dart';

class SignInWithGoogleAuth extends UseCaseWithoutParams<LocalUser> {
  const SignInWithGoogleAuth(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<LocalUser> call() {
    return _repo.signInWithGoogle();
  }
}
