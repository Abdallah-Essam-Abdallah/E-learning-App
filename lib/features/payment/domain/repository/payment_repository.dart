import 'package:courses_app/features/payment/domain/entity/auth_request_entity.dart';
import 'package:courses_app/features/payment/domain/entity/order_request_entity.dart';
import 'package:courses_app/features/payment/domain/entity/payment_request_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class PaymentRepository {
  Future<Either<Failure, AuthinticationRequestEntity>> requestAuth();
  Future<Either<Failure, OrderRequestEntity>> requestOrder(
      {required String price});
  Future<Either<Failure, PaymentRequestEntity>> paymentRequest({
    required String price,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  });
  Future<Either<Failure, Unit>> addCourseToBookedCourses(
      {required String course});
}
