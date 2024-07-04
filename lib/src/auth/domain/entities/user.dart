import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.fullName,
  });

  const LocalUser.empty()
      : this(
    uid: '',
    email: '',
    fullName: '',
  );

  @override
  String toString() {
    return 'LocalUser{uid: $uid, email: $email, fullName: $fullName}';
  }

  final String uid;
  final String email;
  final String fullName;

  @override
  List<Object?> get props => [uid, email];

  LocalUser copyWith({
    String? uid,
    String? email,
    String? fullName,
  }) {
    return LocalUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
    );
  }
}
