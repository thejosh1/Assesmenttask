import 'package:pridera_assesment_task/core/usecases/usecase.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/auth/domain/repo/auth_repo.dart';

class ForgotPassword extends UseCaseWithParams<void, String> {
  const ForgotPassword(this._repo);
  
  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(params);
}
