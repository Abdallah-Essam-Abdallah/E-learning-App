part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSignUpLoadedState extends AuthenticationState {}

class AuthenticationSignInWithEmailAndPassworsLoadedState
    extends AuthenticationState {}

class ResetPasswordLoadingState extends AuthenticationState {}

class ResetPasswordLoadedState extends AuthenticationState {}

class ResetPasswordErrorState extends AuthenticationState {
  final String error;

  const ResetPasswordErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthenticationSignInWithGoogleLoadedState extends AuthenticationState {
  final User user;

  const AuthenticationSignInWithGoogleLoadedState({required this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticationErrorState extends AuthenticationState {
  final String error;

  const AuthenticationErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
