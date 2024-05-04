import 'dart:convert';

import 'package:clean_rchitecture_tdd_bloc/core/utils/typedef.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/data/models/user_model.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test('should be a subclass of [User] entity', () {
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return [UserModel] with right data', () {
      final result = UserModel.fromMap(tMap);
      expect(
        result,
        equals(tModel),
      );
    });
  });

  group('fromJson', () {
    test('should return [UserModel] with right data', () {
      final result = UserModel.fromJson(tJson);
      expect(
        result,
        equals(tModel),
      );
    });
  });

  group('toMap', () {
    test('should return [Map] with right data', () {
      final result = tMap;
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return [Json] String with right data', () {
      final result = tModel.toJson();
      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test('should return [UserModel] with diff data', () {
      final result = tModel.copyWith(name: 'Ken');
      expect(result.name, equals('Ken'));
    });
  });
}
