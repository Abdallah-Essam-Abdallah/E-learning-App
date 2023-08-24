import 'package:bloc/bloc.dart';

import 'package:courses_app/features/authentication/domain/usecases/resetpassword_usecase.dart';
import 'package:courses_app/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:courses_app/features/authentication/domain/usecases/signinwithgoogle_usecase.dart';

import 'package:courses_app/features/authentication/domain/usecases/signup_usecase.dart';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignUpUseCase signUpUseCase;
  final SignInWithEmailAndPasswordUseCase signInWithEmailAndPasswordUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;

  final ResetPasswordUseCase resetPasswordUseCase;

  AuthenticationBloc({
    required this.signUpUseCase,
    required this.signInWithEmailAndPasswordUseCase,
    required this.signInWithGoogleUseCase,
    required this.resetPasswordUseCase,
  }) : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is SignUpEvent) {
        emit(AuthenticationLoadingState());
        final response = await signUpUseCase.call(
            email: event.email,
            password: event.password,
            userName: event.userName,
            phoneNumber: event.phoneNumber);
        response.fold(
            (faliure) => emit(AuthenticationErrorState(error: faliure.message)),
            (success) => emit(AuthenticationSignUpLoadedState()));
      } else if (event is SignInWithEmailAndPasswordEvent) {
        emit(AuthenticationLoadingState());
        final response = await signInWithEmailAndPasswordUseCase.call(
            event.email, event.password);
        response.fold(
            (faliure) => emit(AuthenticationErrorState(error: faliure.message)),
            (success) =>
                emit(AuthenticationSignInWithEmailAndPassworsLoadedState()));
      } else if (event is SignInWithGoogleEvent) {
        emit(AuthenticationLoadingState());
        final response = await signInWithGoogleUseCase.call();
        response.fold(
            (faliure) => emit(AuthenticationErrorState(error: faliure.message)),
            (success) => emit(
                AuthenticationSignInWithGoogleLoadedState(user: success!)));
      } else if (event is ResetPasswordEvent) {
        emit(ResetPasswordLoadingState());
        final response = await resetPasswordUseCase.call(email: event.email);
        response.fold(
            (faliure) => emit(ResetPasswordErrorState(error: faliure.message)),
            (success) => emit(ResetPasswordLoadedState()));
      }
    });
  }
}
