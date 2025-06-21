

import '../../Domain/Entity/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone1,
    super.phone2,
    super.profilePicture,
    required super.isAdmin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone1: json['phone1'],
      phone2: json['phone2'],
      profilePicture: json['profile_picture'],
      isAdmin: json['is_admin'] == 1 || json['is_admin'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone1': phone1,
      'phone2': phone2,
      'profile_picture': profilePicture,
      'is_admin': isAdmin ? 1 : 0,
    };
  }

  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      phone1: phone1,
      phone2: phone2,
      profilePicture: profilePicture,
      isAdmin: isAdmin,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phone1: user.phone1,
      phone2: user.phone2,
      profilePicture: user.profilePicture,
      isAdmin: user.isAdmin,
    );
  }
}