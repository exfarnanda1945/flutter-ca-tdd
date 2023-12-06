import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_flutter/core/utils/typedef.dart';
import 'package:tdd_flutter/src/auth_feat/data/models/user_model.dart';
import 'package:tdd_flutter/src/auth_feat/domain/entities/user.dart';
import '../../../../utils/reader.dart';

void main() {
  const userModel = UserModel.empty();
  // json to string
  final userJson = Reader.readAsStringTrim('test/utils/json/user.json');
  // string from json to map
  final userMap = jsonDecode(userJson) as DataMap;

  test('should be subclass from [User] entity', () {
    expect(userModel, isA<User>());
  });

  group("fromMap", () {
    test("should return a [UserModel] with the correct data", () {
      final result = UserModel.fromMap(userMap);
      expect(result, equals(userModel));
    });
  });

  group("fromJson", () {
    test("should return a [UserModel] with the correct data", () {
      final result = UserModel.fromJson(userJson);
      expect(result, equals(userModel));
    });
  });

  group("toMap", () {
    test("should return a [DataMap] with the correct data", () {
      final result = userModel.toMap();
      expect(result, equals(userMap));
    });
  });

  group("toJson", () {
    test("should return a [String] with the correct data", () {
      final result = userModel.toJson();
      expect(result, equals(userJson));
    });
  });

  group("copyWith", () {
    test("should return a [UserModel] with the different data", () {
      final result = userModel.copyWith(name: "Miko");
      expect(result.name, equals("Miko"));
      expect(result, isNot(userModel));
    });
  });
}
