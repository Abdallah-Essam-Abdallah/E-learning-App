import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

class NoInternetFailure extends Failure {
  const NoInternetFailure(super.message);

  @override
  List<Object?> get props => [message];
}

////authintication faliures
class InvalidEmailFaliure extends Failure {
  const InvalidEmailFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class WrongPasswordFaliure extends Failure {
  const WrongPasswordFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class TooManyRequestsFaliure extends Failure {
  const TooManyRequestsFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class UserNotFoundFaliure extends Failure {
  const UserNotFoundFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class EmailAlreadyInUseFaliure extends Failure {
  const EmailAlreadyInUseFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class WeakPasswordFaliure extends Failure {
  const WeakPasswordFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class UnexpectedFaliure extends Failure {
  const UnexpectedFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class SignOutFaliure extends Failure {
  const SignOutFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class AccountExistsWithDifferentCredentialFaliure extends Failure {
  const AccountExistsWithDifferentCredentialFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class InvalidCredentialFaliure extends Failure {
  const InvalidCredentialFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class SignInWithGoogleFaliure extends Failure {
  const SignInWithGoogleFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class CreateUserInDatabaseFaliure extends Failure {
  const CreateUserInDatabaseFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class GetUserDataFaliure extends Failure {
  const GetUserDataFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class ResetPasswordFaliure extends Failure {
  const ResetPasswordFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

////courses faliures
class GetCourseDetailsFaliure extends Failure {
  const GetCourseDetailsFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class GetTopRatedCoursesFaliure extends Failure {
  const GetTopRatedCoursesFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class GetCoursesByCategoryFaliure extends Failure {
  const GetCoursesByCategoryFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class GetCoursesBySearchFaliure extends Failure {
  const GetCoursesBySearchFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

////favorites faliures
class AddCourseToFavoriteFaliure extends Failure {
  const AddCourseToFavoriteFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class GetFavoriteCoursesFaliure extends Failure {
  const GetFavoriteCoursesFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

////profile faliures
class ImageUplodedFaliure extends Failure {
  const ImageUplodedFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class NoImageChoosedFaliure extends Failure {
  const NoImageChoosedFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

////chat faliures
class SendMessageFaliure extends Failure {
  const SendMessageFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class GetMessageFaliure extends Failure {
  const GetMessageFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class SendVoiceMessageFaliure extends Failure {
  const SendVoiceMessageFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class GetVoiceMessageFaliure extends Failure {
  const GetVoiceMessageFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

////payment faliures
class RequestPaymentAuthFaliure extends Failure {
  const RequestPaymentAuthFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class RequestPaymentOrderFaliure extends Failure {
  const RequestPaymentOrderFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class RequestPaymentFaliure extends Failure {
  const RequestPaymentFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class AddCourseToBookedCoursesFaliure extends Failure {
  const AddCourseToBookedCoursesFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class GetVideoFaliure extends Failure {
  const GetVideoFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class GetBookedCoursesFaliure extends Failure {
  const GetBookedCoursesFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class AddRatingFaliure extends Failure {
  const AddRatingFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class GetRatingFaliure extends Failure {
  const GetRatingFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class AddPostFaliure extends Failure {
  const AddPostFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class GetPostsFaliure extends Failure {
  const GetPostsFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class AddLikeFaliure extends Failure {
  const AddLikeFaliure(super.message);

  @override
  List<Object?> get props => [message];
}

class AddCommentFaliure extends Failure {
  const AddCommentFaliure(super.message);

  @override
  List<Object?> get props => [message];
}
