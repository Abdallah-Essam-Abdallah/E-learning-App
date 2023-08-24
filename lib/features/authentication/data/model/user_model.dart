import 'package:courses_app/features/authentication/domain/entity/user.dart';

// ignore: must_be_immutable
class UserModel extends UserEntity {
  UserModel(super.userName, super.userId, super.email, super.phoneNumber,
      super.image);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        json['displayName'],
        json['userId'],
        json['email'],
        json['phoneNumber'],
        json['image'],
      );

  Map<String, dynamic> toJson() => {
        'displayName': userName,
        'userId': userId,
        'email': email,
        'phoneNumber': phoneNumber,
        'image': image,
      };
}
