import 'package:equatable/equatable.dart';

class OrderRequestEntity extends Equatable {
  final int id;

  const OrderRequestEntity({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
