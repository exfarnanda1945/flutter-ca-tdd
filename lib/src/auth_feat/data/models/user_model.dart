import 'dart:convert';

import 'package:tdd_flutter/core/utils/typedef.dart';
import 'package:tdd_flutter/src/auth_feat/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.createdAt,
      required super.name,
      required super.avatar});

  UserModel.fromMap(DataMap map)
      : this(
          avatar: map["avatar"] as String,
          createdAt: map["createdAt"] as String,
          id: map["id"] as String,
          name: map["name"] as String,
        );

  DataMap toMap() =>
      {"id": id, "avatar": avatar, "createdAt": createdAt, "name": name};

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  String toJson() => jsonEncode(toMap());

  UserModel copyWith(
          {String? avatar, String? id, String? name, String? createdAt}) =>
      UserModel(
          id: id ?? this.id,
          createdAt: createdAt ?? this.createdAt,
          name: name ?? this.name,
          avatar: avatar ?? this.avatar);
}
