import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/core/errors/exceptions.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/auth/data/datasource/remote_data_source.dart';
import 'package:pridera_assesment_task/src/auth/data/model/local_user_model.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {
  String _uid = 'Test uid';

  @override
  String get uid => _uid;

  set uid(String value) {
    if (_uid != value) _uid = value;
  }
}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential([User? user]) : _user = user;

  User? _user;

  @override
  User? get user => _user;

  set user(User? value) {
    if (_user != value) _user = user;
  }
}

void main() {
  late FirebaseAuth authClient;
  late FirebaseFirestore cloudStoreClient;
  late AuthRemoteDataSourceImpl dataSource;
  late UserCredential userCredential;
  late MockUser mockUser;
  late MockGoogleSignIn googleSignIn;
  late GoogleSignInAccount? signInAccount;
  late GoogleSignInAuthentication googleSignInAuthentication;
  late AuthCredential authCredential;
  late DocumentReference<DataMap> documentReference;
  const tUser = LocalUserModel.empty();

  setUpAll(() async {
    authClient = MockFirebaseAuth();
    cloudStoreClient = FakeFirebaseFirestore();
    documentReference = cloudStoreClient.collection('users').doc();
    await documentReference.set(
      tUser.copyWith(uid: documentReference.id).toMap(),
    );
    mockUser = MockUser()..uid = documentReference.id;
    userCredential = MockUserCredential(mockUser);
    googleSignIn = MockGoogleSignIn();
    signInAccount = await googleSignIn.signIn();
    googleSignInAuthentication = await signInAccount!.authentication;
    authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    dataSource = AuthRemoteDataSourceImpl(
      googleSignIn: googleSignIn,
      authClient: authClient,
      cloudStoreClient: cloudStoreClient,

    );
    registerFallbackValue(authCredential);
    when(() => authClient.currentUser).thenReturn(mockUser);
  });

  final tFirebaseAuthException = FirebaseAuthException(
    code: 'user not found',
    message: 'There is no user record corresponding to this',
  );

  const tEmail = 'testEmail@email.org';
  const tPassword = 'Test password';
  const tFullName = 'Test fullName';

  group('forgotPassword', () {
    test(
      'should complete successfully when no [Exception] is thrown',
      () async {
        when(
          () => authClient.sendPasswordResetEmail(email: any(named: 'email')),
        ).thenAnswer((_) async => Future.value);

        final call = dataSource.forgotPassword(tEmail);

        expect(call, completes);
        verify(() => authClient.sendPasswordResetEmail(email: tEmail))
            .called(1);
        verifyNoMoreInteractions(authClient);
      },
    );

    test(
      'should throw [ServerException] when [FirebaseAuthException] is thrown',
      () async {
        when(
          () => authClient.sendPasswordResetEmail(email: any(named: 'email')),
        ).thenThrow(tFirebaseAuthException);

        final call = dataSource.forgotPassword;

        expect(() => call(tEmail), throwsA(isA<ServerException>()));
        verify(() => authClient.sendPasswordResetEmail(email: tEmail))
            .called(1);
        verifyNoMoreInteractions(authClient);
      },
    );
  });

  group('sign in', () {
    test('should return [LocalUserModel]', () async {
      when(
        () => authClient.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => userCredential);

      final result =
          await dataSource.signIn(email: tEmail, password: tPassword);

      final userCred = userCredential.user!;
      expect(result.uid, userCred.uid);
      verify(
        () => authClient.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });

    test(
      'should throw [ServerException] when [FirebaseAuthException] is thrown',
      () async {
        when(
          () => authClient.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);

        final call = dataSource.signIn;

        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()),
        );

        verify(
          () => authClient.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(authClient);
      },
    );
  });

  group('sign up', () {
    test('should complete successfully when no [Exception] is thrown',
        () async {
      when(
        () => authClient.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => userCredential);

      when(() => userCredential.user!.updateDisplayName(any()))
          .thenAnswer((_) async => Future.value);

      final call = dataSource.signUp(
        email: tEmail,
        password: tPassword,
        fullName: tFullName,
      );
      expect(call, completes);
      verify(
        () => authClient.createUserWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);

      await untilCalled(() => userCredential.user?.updateDisplayName(any()));
      verify(() => userCredential.user?.updateDisplayName(tFullName)).called(1);
      verifyNoMoreInteractions(authClient);
    });

    test(
      'should throw [ServerException] on [FirebaseAuthException]',
      () async {
        when(
          () => authClient.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);

        final call = dataSource.signUp;

        expect(
          () => call(email: tEmail, password: tPassword, fullName: tFullName),
          throwsA(isA<ServerException>()),
        );
        verify(
              () => authClient.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
      },
    );
  });

  group('Google sign in', () {
    test('should return idToken and accessToken when authenticating', () async {
      final signInAccount = await googleSignIn.signIn();
      final signInAuthentication = await signInAccount!.authentication;
      expect(signInAuthentication, isNotNull);
      expect(googleSignIn.currentUser, isNotNull);
      expect(signInAuthentication.accessToken, isNotNull);
      expect(signInAuthentication.idToken, isNotNull);
    });

    test('should return null when google login is cancelled by the user',
            () async {
          googleSignIn.setIsCancelled(true);
          final signInAccount = await googleSignIn.signIn();
          expect(signInAccount, isNull);
        });
    test(
        'testing google login twice, once cancelled, once not cancelled at '
            'the same test.', () async {
      googleSignIn.setIsCancelled(true);
      final signInAccount = await googleSignIn.signIn();
      expect(signInAccount, isNull);
      googleSignIn.setIsCancelled(false);
      final signInAccountSecondAttempt = await googleSignIn.signIn();
      expect(signInAccountSecondAttempt, isNotNull);
    });

    test('sign in with google', () async {
      when(() => authClient.signInWithCredential(any()))
          .thenAnswer((_) async => userCredential);
      final result = await dataSource.signInWithGoogle();
      expect(result.uid, userCredential.user!.uid);
      verify(() => authClient.signInWithCredential(any())).called(1);
      verifyNoMoreInteractions(authClient);
    });

    test(
      'should throw [ServerException] when [FirebaseAuthException] is thrown',
          () async {
        when(() => authClient.signInWithCredential(any()))
            .thenThrow(tFirebaseAuthException);

        final call = dataSource.signInWithGoogle;

        expect(call, throwsA(isA<ServerException>()));
        verify(() => authClient.signInWithCredential(any())).called(1);
        verifyNoMoreInteractions(authClient);
      },
    );
  });
}
