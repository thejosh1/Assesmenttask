import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.fullName,
  });

  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          fullName: map['fullName'] as String,
        );

  const LocalUserModel.empty()
      : this(
          uid: '',
          email: '',
          fullName: '',
        );

  @override
  LocalUserModel copyWith({
    String? uid,
    String? email,
    String? profilePic,
    String? fullName,
    String? profession,
    List<String>? communityIds,
    List<String>? following,
    List<String>? followers,
    List<String>? collections,
  }) {
    return LocalUserModel(
      uid: uid ?? super.uid,
      email: email ?? super.email,
      fullName: fullName ?? super.fullName,
    );
  }

  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
    };
  }
}
