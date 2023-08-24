import 'package:courses_app/features/payment/domain/entity/order_request_entity.dart';

class OrderRequestModel extends OrderRequestEntity {
  const OrderRequestModel({
    required super.id,
  });

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) =>
      OrderRequestModel(
        id: json["id"],
      );
}
