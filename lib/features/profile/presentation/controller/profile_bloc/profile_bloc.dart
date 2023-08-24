import 'package:bloc/bloc.dart';

import 'package:courses_app/features/profile/domain/usecases/signout_usecase.dart';
import 'package:courses_app/features/profile/domain/usecases/uploadprofileimage_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../authentication/domain/entity/user.dart';
import '../../../domain/usecases/getuserdata_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UploadProfileImageUsecase uploadProfileImageUsecase;
  final SignOutUseCase signOutUseCase;
  final GetUserDataUseCase getUserDataUseCase;
  UserEntity? user;

  ProfileBloc({
    required this.uploadProfileImageUsecase,
    required this.signOutUseCase,
    required this.getUserDataUseCase,
  }) : super(ProfileInitial()) {
    on<UploadProfileImageEvent>((event, emit) async {
      emit(UploadProfileImageLoadingState());
      final result = await uploadProfileImageUsecase.call();
      result.fold(
          (faliure) =>
              emit(UploadProfileImageErrorState(error: faliure.message)),
          (success) {
        user!.image = success;
        emit(UploadProfileImageLoadedState());
      });
    });

    on<GetUserDataEvent>((event, emit) async {
      emit(GetUserDataLoadingState());
      final response = await getUserDataUseCase.call();
      response.fold(
          (faliure) => emit(GetUserDataErrorState(error: faliure.message)),
          (success) {
        user = success;
        emit(GetUserDataLoadedState(user: success));
      });
    });

    on<SignOutEvent>((event, emit) async {
      emit(SignoutLoadingState());
      final response = await signOutUseCase.call();
      response
          .fold((faliure) => emit(SignoutErrorState(error: faliure.message)),
              (success) {
        emit(SignoutLoadedState());
      });
    });
  }
}
