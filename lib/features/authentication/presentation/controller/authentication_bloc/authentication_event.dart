part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInWithEmailAndPasswordEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInWithEmailAndPasswordEvent(
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String userName;
  final String phoneNumber;

  const SignUpEvent({
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.userName,
  });

  @override
  List<Object> get props => [email, password, userName, phoneNumber];
}

class ResetPasswordEvent extends AuthenticationEvent {
  final String email;

  const ResetPasswordEvent(this.email);
  @override
  List<Object> get props => [email];
}

class SignInWithGoogleEvent extends AuthenticationEvent {}

class SignInWithFacebookEvent extends AuthenticationEvent {}
