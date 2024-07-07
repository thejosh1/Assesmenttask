import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/core/errors/failures.dart';
import 'package:pridera_assesment_task/src/auth/data/model/local_user_model.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/sign_in_usecase.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/sign_in_with_facebook_usecase.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/sign_in_with_google_usecase.dart';
import 'package:pridera_assesment_task/src/auth/domain/usecase/sign_up_usecase.dart';
import 'package:pridera_assesment_task/src/auth/presentation/auth/auth_bloc.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignUp extends Mock implements SignUp {}

class MockForgotPassword extends Mock implements ForgotPassword {}

class MockGoogleSignIn extends Mock implements SignInWithGoogleAuth {}

class MockFacebookSignIn extends Mock implements FacebookSignIn {}

void main() {
  late SignIn signIn;
  late SignUp signUp;
  late SignInWithGoogleAuth googleSignIn;
  late FacebookSignIn facebookSignIn;
  late ForgotPassword forgotPassword;
  late AuthBloc authBloc;

  const tSignUpParams = SignUpParams.empty();
  const tSignInParams = SignInParams.empty();

  setUp(() {
    signIn = MockSignIn();
    signUp = MockSignUp();
    forgotPassword = MockForgotPassword();
    googleSignIn = MockGoogleSignIn();
    facebookSignIn = MockFacebookSignIn();
    authBloc = AuthBloc(
      signIn: signIn,
      signUp: signUp,
      googleSignIn: googleSignIn,
      facebookSignIn: facebookSignIn,
      forgotPassword: forgotPassword,
    );
  });

  setUpAll(() {
    registerFallbackValue(tSignInParams);
    registerFallbackValue(tSignUpParams);
  });

  tearDown(() => authBloc.close());

  test('initial state [InitialState]', () {
    expect(authBloc.state, const AuthInitial());
  });

  final tServerFailure = ServerFailure(
    message: 'user not found',
    statusCode: 'There is no user record corresponding to this identifier. '
        'The user may have been deleted',
  );

  group('sign in Event', () {
    const tUser = LocalUserModel.empty();
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, SignedIn] when [SignedInEvent is added]',
      build: () {
        when(() => signIn(any())).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSignInParams.email,
          password: tSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const SignedIn(tUser),
      ],
      verify: (_) {
        verify(
          () => signIn(
            tSignInParams,
          ),
        ).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when signIn fails',
      build: () {
        when(() => signIn(any())).thenAnswer((_) async => Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSignInParams.email,
          password: tSignUpParams.password,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(errorMessage: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => signIn(
            tSignInParams,
          ),
        ).called(1);
      },
    );
  });

  group('sign up Event', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, SignedUp] when [SignedUpEvent is added]',
      build: () {
        when(() => signUp(any())).thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          email: tSignUpParams.email,
          password: tSignUpParams.password,
          fullName: tSignUpParams.fullName,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const SignedUp(),
      ],
      verify: (_) {
        verify(
          () => signUp(
            tSignUpParams,
          ),
        ).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when signUp fails',
      build: () {
        when(() => signUp(any())).thenAnswer((_) async => Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          email: tSignUpParams.email,
          password: tSignUpParams.password,
          fullName: tSignUpParams.fullName,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(errorMessage: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => signUp(
            tSignUpParams,
          ),
        ).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );
  });

  group('Google signIn event', () {
    const tUser = LocalUserModel.empty();
    //sign in with google
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading] and [SignedInState] when sign in event is '
          'added',
      build: () {
        when(() => googleSignIn()).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignInWithGoogleEvent()),
      expect: () => [const AuthLoading(), const SignInWithGoogle()],
      verify: (_) {
        verify(() => googleSignIn()).called(1);
        verifyNoMoreInteractions(googleSignIn);
      },
    );

    //error state for google
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading] and [AuthError] when sign in fails',
      build: () {
        when(() => googleSignIn()).thenAnswer(
          (_) async => Left(tServerFailure),
        );
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignInWithGoogleEvent()),
      expect: () => [
        const AuthLoading(),
        AuthError(errorMessage: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => googleSignIn()).called(1);
        verifyNoMoreInteractions(googleSignIn);
      },
    );
  });

  group('Facebook signIn event', () {
    const tUser = LocalUserModel.empty();
    //sign in with google
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading] and [SignedInState] when sign in event is '
          'added',
      build: () {
        when(() =>facebookSignIn()).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignInWithFacebookEvent()),
      expect: () => [const AuthLoading(), const SignInWithFacebook()],
      verify: (_) {
        verify(() => facebookSignIn()).called(1);
        verifyNoMoreInteractions(facebookSignIn);
      },
    );

    //error state for facebook
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading] and [AuthError] when sign in fails',
      build: () {
        when(() => facebookSignIn()).thenAnswer(
              (_) async => Left(tServerFailure),
        );
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignInWithFacebookEvent()),
      expect: () => [
        const AuthLoading(),
        AuthError(errorMessage: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => facebookSignIn()).called(1);
        verifyNoMoreInteractions(facebookSignIn);
      },
    );
  });

  group('forgot password event', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, ForgotPasswordEvent] when '
          '[ForgotPasswordEvent]'
      ' is added and is successful',
      build: () {
        when(() => forgotPassword(any()))
            .thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(const ForgotPasswordEvent(email: 'email')),
      expect: () => [
        const AuthLoading(),
        const ForgotPasswordState(),
      ],
      verify: (_) {
        verify(() => forgotPassword('email')).called(1);
        verifyNoMoreInteractions(forgotPassword);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when [ForgotPasswordEvent]'
      ' is added and it fails',
      build: () {
        when(() => forgotPassword(any()))
            .thenAnswer((_) async => left(tServerFailure));
        return authBloc;
      },
      act: (bloc) => bloc.add(const ForgotPasswordEvent(email: 'email')),
      expect: () => [
        const AuthLoading(),
        AuthError(errorMessage: tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => forgotPassword('email')).called(1);
        verifyNoMoreInteractions(forgotPassword);
      },
    );
  });
}
