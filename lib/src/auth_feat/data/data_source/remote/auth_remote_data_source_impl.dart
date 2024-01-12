import 'dart:convert';

import 'package:tdd_flutter/core/errors/server_error.dart';
import 'package:tdd_flutter/core/utils/constants.dart';
import 'package:tdd_flutter/core/utils/typedef.dart';
import 'package:tdd_flutter/src/auth_feat/data/models/user_model.dart';

import 'auth_remote_data_source.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final result = await _client.post(Uri.parse("${Constants.BASE_URL}users"),
          body: jsonEncode(
              {"createdAt": createdAt, "name": name, "avatar": avatar}));

      if (result.statusCode != 200 && result.statusCode != 201) {
        throw ServerError(message: result.body, statusCode: result.statusCode);
      }
    } on ServerError {
      rethrow;
    } catch (e) {
      throw ServerError(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> listUser() async {
    try {
      final response =
          await _client.get(Uri.parse("${Constants.BASE_URL}users"));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerError(
            message: response.body, statusCode: response.statusCode);
      }

      final toDataMap = List<DataMap>.from(jsonDecode(response.body) as List);
      final result = toDataMap.map((item) => UserModel.fromMap(item)).toList();

      return result;
    } on ServerError {
      rethrow;
    } catch (e) {
      throw ServerError(message: e.toString(), statusCode: 505);
    }
  }
}
