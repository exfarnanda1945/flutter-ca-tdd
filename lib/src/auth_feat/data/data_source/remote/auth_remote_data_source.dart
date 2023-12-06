import 'package:tdd_flutter/src/auth_feat/data/models/user_model.dart';

abstract class AuthRemoteDataSource{
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> listUser();
}