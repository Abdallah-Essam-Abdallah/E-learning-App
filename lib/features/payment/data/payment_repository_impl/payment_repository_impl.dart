import 'package:courses_app/core/error/failure.dart';
import 'package:courses_app/features/payment/data/datasource/payment_datasource.dart';
import 'package:courses_app/features/payment/domain/entity/auth_request_entity.dart';
import 'package:courses_app/features/payment/domain/entity/order_request_entity.dart';
import 'package:courses_app/features/payment/domain/entity/payment_request_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/internet_connection.dart';
import '../../../../core/utils/appstrings.dart';
import '../../domain/repository/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentDataSource paymentDataSource;
  final InternetConnection internetConnection;

  PaymentRepositoryImpl(this.paymentDataSource, this.internetConnection);

  @override
  Future<Either<Failure, AuthinticationRequestEntity>> requestAuth() async {
    if (await internetConnection.isInternetConnected) {
      try {
        final result = await paymentDataSource.requestAuth();
        return right(result);
      } catch (e) {
        return left(RequestPaymentAuthFaliure(e.toString()));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, PaymentRequestEntity>> paymentRequest(
      {required String price,
      required String firstName,
      required String lastName,
      required String email,
      required String phone}) async {
    if (await internetConnection.isInternetConnected) {
      try {
        final result = await paymentDataSource.requestPayment(
            price: price,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone);
        return right(result);
      } catch (e) {
        return left(RequestPaymentFaliure(e.toString()));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, OrderRequestEntity>> requestOrder(
      {required String price}) async {
    if (await internetConnection.isInternetConnected) {
      try {
        final result = await paymentDataSource.requestOrder(price: price);
        return right(result);
      } catch (e) {
        return left(RequestPaymentOrderFaliure(e.toString()));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> addCourseToBookedCourses(
      {required String course}) async {
    if (await internetConnection.isInternetConnected) {
      try {
        await paymentDataSource.addCourseToBookedCourses(course: course);
        return right(unit);
      } catch (e) {
        return left(AddCourseToBookedCoursesFaliure(e.toString()));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }
}
