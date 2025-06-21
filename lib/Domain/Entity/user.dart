import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone1;
  final String? phone2;
  final String? profilePicture;
  final bool isAdmin;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone1,
    this.phone2,
    this.profilePicture,
    required this.isAdmin,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone1,
    String? phone2,
    String? profilePicture,
    bool? isAdmin,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone1: phone1 ?? this.phone1,
      phone2: phone2 ?? this.phone2,
      profilePicture: profilePicture ?? this.profilePicture,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  @override
  List<Object?> get props => [id, name, email, phone1, phone2, profilePicture, isAdmin];
}