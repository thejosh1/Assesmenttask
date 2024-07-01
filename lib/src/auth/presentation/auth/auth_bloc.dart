import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pridera_assesment_task/src/auth/domain/entities/user.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/sign_in_usecase.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/sign_in_with_google_usecase.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/sign_up_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
    required SignUp signUp,
    required SignInWithGoogleAuth googleSignIn,
    required ForgotPassword forgotPassword,
  })  : _signIn = signIn,
        _signUp = signUp,
        _signInWithGoogle = googleSignIn,
        _forgotPassword = forgotPassword,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });

    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpHandler);
    on<SignInWithGoogleEvent>(_googleSignInHandler);
    on<ForgotPasswordEvent>(_forgotPasswordHandler);
  }

  final SignIn _signIn;
  final SignUp _signUp;
  final SignInWithGoogleAuth _signInWithGoogle;
  final ForgotPassword _forgotPassword;

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signIn(
      SignInParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthError(errorMessage: failure.errorMessage)),
      (user) => emit(SignedIn(user)),
    );
  }

  Future<void> _signUpHandler(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signUp(
      SignUpParams(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(errorMessage: failure.errorMessage)),
      (_) => emit(const SignedUp()),
    );
  }

  Future<void> _googleSignInHandler(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signInWithGoogle();
    result.fold(
      (failure) => emit(AuthError(errorMessage: failure.errorMessage)),
      (_) => emit(const SignInWithGoogle()),
    );
  }

  Future<void> _forgotPasswordHandler(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _forgotPassword(event.email);
    result.fold(
      (failure) => emit(AuthError(errorMessage: failure.errorMessage)),
      (_) => emit(const ForgotPasswordState()),
    );
  }
}
