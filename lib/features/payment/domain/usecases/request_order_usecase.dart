import 'package:courses_app/features/payment/domain/entity/order_request_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repository/payment_repository.dart';

class RequestOrderUseCase {
  final PaymentRepository paymentRepository;

  const RequestOrderUseCase(this.paymentRepository);

  Future<Either<Failure, OrderRequestEntity>> call(
      {required String price}) async {
    return await paymentRepository.requestOrder(price: price);
  }
}
