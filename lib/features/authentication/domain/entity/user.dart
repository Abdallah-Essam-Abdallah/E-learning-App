import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserEntity extends Equatable {
  final String? userName;
  final String? userId;
  final String? email;
  final String? phoneNumber;
  String? image;

  UserEntity(
      this.userName, this.userId, this.email, this.phoneNumber, this.image);

  @override
  List<Object?> get props => [
        userName,
        userId,
        email,
        phoneNumber,
        image,
      ];
}
