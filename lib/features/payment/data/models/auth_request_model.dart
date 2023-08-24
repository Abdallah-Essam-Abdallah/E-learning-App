import 'package:courses_app/features/payment/domain/entity/auth_request_entity.dart';

class AuthinticationRequestModel extends AuthinticationRequestEntity {
  const AuthinticationRequestModel({
    required super.token,
  });

  factory AuthinticationRequestModel.fromJson(Map<String, dynamic> json) =>
      AuthinticationRequestModel(
        token: json["token"],
      );
}
