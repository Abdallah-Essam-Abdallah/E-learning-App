import 'package:courses_app/features/payment/domain/entity/auth_request_entity.dart';
import 'package:courses_app/features/payment/domain/repository/payment_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class RequestPaymentAuthUseCase {
  final PaymentRepository paymentRepository;

  const RequestPaymentAuthUseCase(this.paymentRepository);

  Future<Either<Failure, AuthinticationRequestEntity>> call() async {
    return await paymentRepository.requestAuth();
  }
}
