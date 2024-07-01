import 'package:equatable/equatable.dart';
import 'package:pridera_assesment_task/core/usecases/usecase.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/auth/domain/entities/user.dart';
import 'package:pridera_assesment_task/src/auth/domain/repo/auth_repo.dart';

class SignIn extends UseCaseWithParams<LocalUser, SignInParams> {
  const SignIn(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<LocalUser> call(SignInParams params) =>
      _repo.signIn(email: params.email, password: params.password);
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  //to make testing easier we can an empty instance of sign in params so we
  // don't have to manually provide the arguments
  const SignInParams.empty()
      : email = '',
        password = '';

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}
