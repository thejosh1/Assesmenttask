import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/auth/data/model/local_user_model.dart';
import 'package:pridera_assesment_task/src/auth/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = LocalUserModel.empty();

  test(
    'should be a subclass of [LocalUser] entity',
        () async {
      expect(tUserModel, isA<LocalUser>());
    },
  );

  final tMap = jsonDecode(fixture('user.json')) as DataMap;
  group('fromMap', () {
    test('should return a valid [localUserModel] from map', () {
      final result = LocalUserModel.fromMap(tMap);

      expect(result, isA<LocalUserModel>());
      expect(result, equals(tUserModel));
    });
    test('should throw an error when map is invalid', () {
      final map = DataMap.from(tMap)..remove('uid');

      const call = LocalUserModel.fromMap;

      expect(() => call(map), throwsA(isA<Error>()));
    });
  });

  group('toMap', () {
    test(
      'should return a valid [DataMap]',
          () {
        final result = tUserModel.toMap();
        expect(result, equals(tMap));
      },
    );
  });

  group('copyWith', () {
    test(
      'should return a valid [LocalUserModel] with the updated values',
          () {
        final result = tUserModel.copyWith(uid: '222rmg');

        expect(result, isA<LocalUserModel>());
        expect(result.uid, '222rmg');

      },
    );
  });
}
