part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

class SignedIn extends AuthState {
  const SignedIn(this.user);

  final LocalUser user;

  @override
  List<Object> get props => [user];
}

class SignedUp extends AuthState {
  const SignedUp();
}

class ForgotPasswordState extends AuthState {
  const ForgotPasswordState();
}

class SignInWithGoogle extends AuthState {
  const SignInWithGoogle();
}

class SignInWithFacebook extends AuthState {
  const SignInWithFacebook();
}

class AuthError extends AuthState {
  const AuthError({required this.errorMessage});

  final String errorMessage;

  @override
  List<String> get props => [errorMessage];
}
