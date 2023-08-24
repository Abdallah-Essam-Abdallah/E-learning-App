part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class UploadProfileImageLoadingState extends ProfileState {}

class UploadProfileImageLoadedState extends ProfileState {}

class UploadProfileImageErrorState extends ProfileState {
  final String error;

  const UploadProfileImageErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class GetUserDataLoadingState extends ProfileState {}

class GetUserDataLoadedState extends ProfileState {
  final UserEntity user;

  const GetUserDataLoadedState({required this.user});
  @override
  List<Object> get props => [user];
}

class GetUserDataErrorState extends ProfileState {
  final String error;

  const GetUserDataErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class SignoutLoadingState extends ProfileState {}

class SignoutLoadedState extends ProfileState {}

class SignoutErrorState extends ProfileState {
  final String error;

  const SignoutErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
