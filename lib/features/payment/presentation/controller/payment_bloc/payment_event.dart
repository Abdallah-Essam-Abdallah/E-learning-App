part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class RequestPaymentAuthEvent extends PaymentEvent {}

class RequestPaymentOrderEvent extends PaymentEvent {
  final String price;

  const RequestPaymentOrderEvent({required this.price});
  @override
  List<Object> get props => [price];
}

class RequestPaymentEvent extends PaymentEvent {
  final String price;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;

  const RequestPaymentEvent(
      {required this.price,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.phone});
  @override
  List<Object> get props => [price, firstname, lastname, email, phone];
}

class AddCourseToBookedCoursesEvent extends PaymentEvent {
  final String course;

  const AddCourseToBookedCoursesEvent({required this.course});
  @override
  List<Object> get props => [course];
}
