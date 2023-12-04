import 'package:equatable/equatable.dart';

// Equatable --> Compare between object (as a value not as an object instance) in flutter without overriding ==
class User extends Equatable {
  const User(
      {required this.id,
      required this.createdAt,
      required this.name,
      required this.avatar});

  const User.empty()
      : this(
            id: 1,
            createdAt: "_empty.createdAt",
            name: "_empty.name",
            avatar: "_empty.avatar");

  final int id;
  final String createdAt;
  final String name;
  final String avatar;

// Compare between object and id as a key
// Whenever the Id are same, thats a same person / user
  @override
  List<Object?> get props => [id];
}
