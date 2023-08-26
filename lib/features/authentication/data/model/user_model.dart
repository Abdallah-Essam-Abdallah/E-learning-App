import 'package:courses_app/features/authentication/domain/entity/user.dart';

// ignore: must_be_immutable
class UserModel extends UserEntity {
  UserModel({
    required super.userName,
    required super.userId,
    required super.email,
    required super.phoneNumber,
    super.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userName: json['displayName'],
        userId: json['userId'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'displayName': userName,
        'userId': userId,
        'email': email,
        'phoneNumber': phoneNumber,
        'image': image,
      };
}
