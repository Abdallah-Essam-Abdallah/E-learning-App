part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymenLoadingState extends PaymentState {}

class RequestPaymentAuthLoadedState extends PaymentState {}

class RequestPaymentAuthErrorState extends PaymentState {
  final String error;

  const RequestPaymentAuthErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class RequestPaymentOrderLoadedState extends PaymentState {}

class RequestPaymentOrderErrorState extends PaymentState {
  final String error;

  const RequestPaymentOrderErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class RequestPaymentLoadedState extends PaymentState {
  final PaymentRequestEntity finalToken;

  const RequestPaymentLoadedState({required this.finalToken});

  @override
  List<Object> get props => [finalToken];
}

class RequestPaymentErrorState extends PaymentState {
  final String error;

  const RequestPaymentErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class AddCourseToBookedCoursesLoadingState extends PaymentState {}

class AddCourseToBookedCoursesLoadedState extends PaymentState {}

class AddCourseToBookedCoursesErrorState extends PaymentState {
  final String error;

  const AddCourseToBookedCoursesErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
