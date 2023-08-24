import 'package:courses_app/features/payment/domain/entity/payment_request_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repository/payment_repository.dart';

class RequestPaymentUseCase {
  final PaymentRepository paymentRepository;

  const RequestPaymentUseCase(this.paymentRepository);

  Future<Either<Failure, PaymentRequestEntity>> call({
    required String price,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    return await paymentRepository.paymentRequest(
        price: price,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone);
  }
}
