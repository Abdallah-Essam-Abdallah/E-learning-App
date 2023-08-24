import '../../domain/entity/payment_request_entity.dart';

class PaymentRequestModel extends PaymentRequestEntity {
  const PaymentRequestModel({required super.token});

  factory PaymentRequestModel.fromJson(Map<String, dynamic> json) =>
      PaymentRequestModel(token: json['token']);
}
