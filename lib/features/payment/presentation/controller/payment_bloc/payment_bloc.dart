import 'package:bloc/bloc.dart';
import 'package:courses_app/features/payment/domain/usecases/addcoursetobookedcourses_usecase.dart';
import 'package:courses_app/features/payment/domain/usecases/request_auth_usecase.dart';
import 'package:courses_app/features/payment/domain/usecases/request_order_usecase.dart';
import 'package:courses_app/features/payment/domain/usecases/request_payment_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/payment_request_entity.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final RequestPaymentAuthUseCase requestPaymentAuthUseCase;
  final RequestOrderUseCase requestOrderUseCase;
  final RequestPaymentUseCase requestPaymentUseCase;
  final AddCourseToBookedCoursesUseCase addCourseToBookedCoursesUseCase;
  static String lastToken = '';
  PaymentBloc({
    required this.requestPaymentAuthUseCase,
    required this.requestOrderUseCase,
    required this.requestPaymentUseCase,
    required this.addCourseToBookedCoursesUseCase,
  }) : super(PaymentInitial()) {
    on<RequestPaymentAuthEvent>((event, emit) async {
      emit(PaymenLoadingState());
      final result = await requestPaymentAuthUseCase.call();
      result.fold(
          (failure) =>
              emit(RequestPaymentAuthErrorState(error: failure.message)),
          (success) {
        print('firstToken : ${success.token}');
        emit(RequestPaymentAuthLoadedState());
      });
    });

    on<RequestPaymentOrderEvent>((event, emit) async {
      emit(PaymenLoadingState());
      final result = await requestOrderUseCase.call(price: event.price);
      result.fold(
          (failure) =>
              emit(RequestPaymentOrderErrorState(error: failure.message)),
          (success) {
        print('id : ${success.id}');
        emit(RequestPaymentOrderLoadedState());
      });
    });

    on<RequestPaymentEvent>((event, emit) async {
      emit(PaymenLoadingState());
      final result = await requestPaymentUseCase.call(
          price: event.price,
          firstName: event.firstname,
          lastName: event.lastname,
          phone: event.phone,
          email: event.email);
      result.fold(
          (failure) => emit(RequestPaymentErrorState(error: failure.message)),
          (success) {
        lastToken = success.token;
        print('lastToken : ${success.token}');
        emit(RequestPaymentLoadedState(finalToken: success));
      });
    });

    on<AddCourseToBookedCoursesEvent>((event, emit) async {
      emit(AddCourseToBookedCoursesLoadingState());
      final result =
          await addCourseToBookedCoursesUseCase.call(course: event.course);
      result.fold(
          (failure) =>
              emit(AddCourseToBookedCoursesErrorState(error: failure.message)),
          (success) => emit(AddCourseToBookedCoursesLoadedState()));
    });
  }
}
