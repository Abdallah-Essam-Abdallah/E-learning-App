import 'package:courses_app/core/utils/appstrings.dart';

abstract class AuthenticationException implements Exception {}

class NoInternetException implements AuthenticationException {
  final String message = AppStrings.internetFaliureMessage;
}

class InvalidEmailException implements AuthenticationException {
  final String message = AppStrings.invalidEmailException;
}

class WrongPasswordException implements AuthenticationException {
  final String message = AppStrings.wrongPasswordException;
}

class TooManyRequestsException implements AuthenticationException {
  final String message = AppStrings.tooManyRequests;
}

class UserNotFoundException implements AuthenticationException {
  final String message = AppStrings.userNotFoundException;
}

class EmailAlreadyInUseException implements AuthenticationException {
  final String message = AppStrings.emailAlreadyInUseException;
}

class WeakPasswordException implements AuthenticationException {
  final String message = AppStrings.weakPasswordException;
}

class UnexpectedException implements AuthenticationException {
  final String message = AppStrings.unexpectedException;
}

class SignOutException implements AuthenticationException {
  final String message = AppStrings.unexpectedException;
}

class AccountExistsWithDifferentCredentialException
    implements AuthenticationException {
  final String message = AppStrings.accountExistsWithDifferentCredential;
}

class InvalidCredentialException implements AuthenticationException {
  final String message = AppStrings.invalidCredential;
}

class SignInWithGoogleException implements AuthenticationException {
  final String message = AppStrings.unexpectedException;
}

class CreateUserInDatabaseException implements AuthenticationException {
  final String message = AppStrings.unexpectedException;
}

class GetUserDataException implements AuthenticationException {
  final String message = AppStrings.unexpectedException;
}

class ResetPasswordException implements AuthenticationException {
  final String message = AppStrings.unexpectedException;
}

//////////////////////////////////////////////////////////////////////////
abstract class CoursesException implements Exception {}

class GetCourseDetailsException implements CoursesException {
  final String message = AppStrings.unexpectedException;
}

class GetTopRatedCoursesException implements CoursesException {
  final String message = AppStrings.unexpectedException;
}

class GetCoursesByCategoryException implements CoursesException {
  final String message = AppStrings.unexpectedException;
}

class GetCoursesBySearchException implements CoursesException {
  final String message = AppStrings.unexpectedException;
}

class AddCourseToFavoriteException implements CoursesException {
  final String message = AppStrings.unexpectedException;
}

class GetFavoriteCoursesException implements CoursesException {
  final String message = AppStrings.unexpectedException;
}

////////////////////////////////////////////////////////////////////////
abstract class ProfileException implements Exception {}

class ImageUplodedException implements ProfileException {
  final String message = AppStrings.imageUploadError;
}

class NoImageChoosedException implements ProfileException {
  final String message = AppStrings.noImageChoosedError;
}

/////////////////////////////////////////////////////////////////////////
abstract class ChatException implements Exception {}

class SendMessageException implements ChatException {
  final String message = AppStrings.unexpectedException;
}

class GetMessageException implements ChatException {
  final String message = AppStrings.unexpectedException;
}

class SendVoiceMessageException implements ChatException {
  final String message = AppStrings.unexpectedException;
}

class GetVoiceMessageException implements ChatException {
  final String message = AppStrings.unexpectedException;
}

/////////////////////////////////////////////////////////////////////////
abstract class PaymentException implements Exception {}

class RequestPaymentAuthException implements PaymentException {
  final String message = AppStrings.unexpectedException;
}

class RequestPaymentOrderException implements PaymentException {
  final String message = AppStrings.unexpectedException;
}

class RequestPaymentException implements PaymentException {
  final String message = AppStrings.unexpectedException;
}

///////////////////////////////////////////////////////////////////////
abstract class ContentException implements Exception {}

class GetVideoException implements ContentException {
  final String message = AppStrings.videoExceptionMessage;
}

class GetBookedCoursesException implements ContentException {
  final String message = AppStrings.unexpectedException;
}

///////////////////////////////////////////////////////////////////////
abstract class RatingException implements Exception {}

class AddRatingException implements ContentException {
  final String message = AppStrings.unexpectedException;
}

class GetRatingException implements ContentException {
  final String message = AppStrings.unexpectedException;
}

///////////////////////////////////////////////////////////////////////
abstract class CommunityException implements Exception {}

class AddPostException implements CommunityException {
  final String message = AppStrings.unexpectedException;
}

class GetPostsException implements CommunityException {
  final String message = AppStrings.unexpectedException;
}

class AddLikeException implements CommunityException {
  final String message = AppStrings.unexpectedException;
}

class AddCommentException implements CommunityException {
  final String message = AppStrings.unexpectedException;
}
