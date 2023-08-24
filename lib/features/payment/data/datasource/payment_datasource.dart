import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses_app/core/network/dio_helper.dart';
import 'package:courses_app/features/payment/constants/payment_constants.dart';
import 'package:courses_app/features/payment/data/models/auth_request_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/order_request_model.dart';
import '../models/payment_request_model.dart';

abstract class PaymentDataSource {
  Future<AuthinticationRequestModel> requestAuth();
  Future<OrderRequestModel> requestOrder({required String price});
  Future<PaymentRequestModel> requestPayment({
    required String price,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  });
  Future<void> addCourseToBookedCourses({required String course});
}

class PaymentDataSourceImpl implements PaymentDataSource {
  final DioHelper dioHelper;
  late AuthinticationRequestModel authinticationRequestModel;
  late OrderRequestModel orderRequestModel;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  PaymentDataSourceImpl(this.dioHelper);
  @override
  Future<AuthinticationRequestModel> requestAuth() async {
    final response =
        await dioHelper.postData(url: PaymentConstants.getAuthToken, data: {
      'api_key': PaymentConstants.apiKey,
    });
    return authinticationRequestModel =
        AuthinticationRequestModel.fromJson(response.data);
  }

  @override
  Future<OrderRequestModel> requestOrder({required String price}) async {
    final response = await dioHelper.postData(
        url: PaymentConstants.getOrderId,
        data: {
          'auth_token': authinticationRequestModel.token,
          'amount_cents': price
        });
    return orderRequestModel = OrderRequestModel.fromJson(response.data);
  }

  @override
  Future<PaymentRequestModel> requestPayment(
      {required String price,
      required String firstName,
      required String lastName,
      required String email,
      required String phone}) async {
    final response = await dioHelper.postData(
      url: PaymentConstants.getPaymentRequest,
      data: {
        "auth_token": authinticationRequestModel.token,
        "amount_cents": price,
        "expiration": 3600,
        "order_id": orderRequestModel.id.toString(),
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": lastName,
          "state": "NA"
        },
        "integration_id": PaymentConstants.integrationCardId,
        "currency": "EGP",
        "lock_order_when_paid": "false"
      },
    );
    return PaymentRequestModel.fromJson(response.data);
  }

  @override
  Future<void> addCourseToBookedCourses({required String course}) async {
    await FirebaseFirestore.instance.collection('Courses').doc(course).update({
      'purchasedBy': FieldValue.arrayUnion([userId])
    });
  }
}
