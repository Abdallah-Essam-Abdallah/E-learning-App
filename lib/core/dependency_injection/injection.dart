import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses_app/core/network/dio_helper.dart';
import 'package:courses_app/features/authentication/data/authentication_repository_impl/authentication_repository_impl.dart';
import 'package:courses_app/features/authentication/data/data_source/authentication_datasource.dart';
import 'package:courses_app/features/authentication/domain/repository/authentication_repository.dart';

import 'package:courses_app/features/authentication/domain/usecases/resetpassword_usecase.dart';
import 'package:courses_app/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:courses_app/features/authentication/domain/usecases/signinwithfacebook_usecase.dart';
import 'package:courses_app/features/authentication/domain/usecases/signinwithgoogle_usecase.dart';

import 'package:courses_app/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:courses_app/features/authentication/presentation/controller/authentication_bloc/authentication_bloc.dart';
import 'package:courses_app/features/chat/data/chat_repository_impl/chat_repository_impl.dart';
import 'package:courses_app/features/chat/data/data_source/chat_datasource.dart';
import 'package:courses_app/features/chat/domain/repository/chat_repository.dart';
import 'package:courses_app/features/chat/domain/usecases/getmessage_usecase.dart';
import 'package:courses_app/features/chat/domain/usecases/sendmessage_usecase.dart';
import 'package:courses_app/features/chat/domain/usecases/sendvoicemessage_usecase.dart';
import 'package:courses_app/features/chat/presentation/controller/chat_bloc/chat_bloc.dart';
import 'package:courses_app/features/community/data/community_repository_impl.dart/community_repository_impl.dart';
import 'package:courses_app/features/community/data/data_source/community_datasource.dart';
import 'package:courses_app/features/community/domain/repository/community_repository.dart';
import 'package:courses_app/features/community/domain/usecases/addcomment_usecase.dart';
import 'package:courses_app/features/community/domain/usecases/addlike_usecase.dart';
import 'package:courses_app/features/community/domain/usecases/addpost_usecase.dart';
import 'package:courses_app/features/community/domain/usecases/getcomments_usecase.dart';
import 'package:courses_app/features/community/domain/usecases/getposts_usecase.dart';
import 'package:courses_app/features/community/domain/usecases/upload_postimage_usecase.dart';
import 'package:courses_app/features/content/data/content_repository_impl/content_repository_impl.dart';
import 'package:courses_app/features/content/data/data_source/content_datasource.dart';
import 'package:courses_app/features/content/domain/repository/content_repository.dart';
import 'package:courses_app/features/content/domain/usecases/getbookedcourses_usecase.dart';
import 'package:courses_app/features/content/domain/usecases/playvideo_usecase.dart';
import 'package:courses_app/features/content/presentation/controller/content_bloc/content_bloc.dart';
import 'package:courses_app/features/courses/data/courses_repository_impl/courses_repository_impl.dart';
import 'package:courses_app/features/courses/data/data_source/courses_datasource.dart';
import 'package:courses_app/features/courses/domain/repository/courses_repository.dart';
import 'package:courses_app/features/courses/domain/usecases/getcoursesbysearch_usecase.dart';

import 'package:courses_app/features/courses/presentation/controller/courses_bloc/courses_bloc.dart';
import 'package:courses_app/features/favorites/data/data_source/favorites_data_source.dart';
import 'package:courses_app/features/favorites/data/favorites_rpository_impl/favorites_repository_impl.dart';
import 'package:courses_app/features/favorites/domain/repository/favorites_repository.dart';
import 'package:courses_app/features/favorites/domain/usecases/addcoursetofavorites_usecase.dart';
import 'package:courses_app/features/favorites/domain/usecases/getfavoritecourses_usecase.dart';
import 'package:courses_app/features/favorites/presentation/favorites_bloc/favorites_bloc.dart';
import 'package:courses_app/features/payment/data/datasource/payment_datasource.dart';
import 'package:courses_app/features/payment/data/payment_repository_impl/payment_repository_impl.dart';
import 'package:courses_app/features/payment/domain/repository/payment_repository.dart';
import 'package:courses_app/features/payment/domain/usecases/addcoursetobookedcourses_usecase.dart';
import 'package:courses_app/features/payment/domain/usecases/request_auth_usecase.dart';
import 'package:courses_app/features/payment/presentation/controller/payment_bloc/payment_bloc.dart';
import 'package:courses_app/features/profile/data/data_source/profile_datasource.dart';
import 'package:courses_app/features/profile/data/profile_repsitory_impl/profile_repsitory_impl.dart';
import 'package:courses_app/features/profile/domain/repository/profile_repository.dart';
import 'package:courses_app/features/profile/domain/usecases/uploadprofileimage_usecase.dart';
import 'package:courses_app/features/profile/presentation/controller/profile_bloc/profile_bloc.dart';
import 'package:courses_app/features/rating/data/data_source/rating_data_source.dart';
import 'package:courses_app/features/rating/data/rating_repository_impl/rating_repository_impl.dart';
import 'package:courses_app/features/rating/domain/repository/rating_repository.dart';
import 'package:courses_app/features/rating/domain/usecases/addrating_usecase.dart';
import 'package:courses_app/features/rating/domain/usecases/getraing_usecase.dart';
import 'package:courses_app/features/rating/presentation/controller/bloc/rating_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/community/presentation/controller/bloc/community_bloc.dart';
import '../../features/courses/domain/usecases/getcoursesbycategory_usecase.dart';
import '../../features/courses/domain/usecases/gettoprated_usecase.dart';
import '../../features/payment/domain/usecases/request_order_usecase.dart';
import '../../features/payment/domain/usecases/request_payment_usecase.dart';
import '../../features/profile/domain/usecases/getuserdata_usecase.dart';
import '../../features/profile/domain/usecases/signout_usecase.dart';
import '../network/internet_connection.dart';

final getIt = GetIt.instance;

Future<void> getitInit() async {
  /// authentication feature///

  /// bloc
  getIt.registerFactory(() => AuthenticationBloc(
        signUpUseCase: getIt(),
        signInWithEmailAndPasswordUseCase: getIt(),
        signInWithGoogleUseCase: getIt(),
        resetPasswordUseCase: getIt(),
      ));

  /// repository
  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getIt(), getIt()));

  /// useCases
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => SignInWithEmailAndPasswordUseCase(getIt()));
  getIt.registerLazySingleton(() => SignInWithGoogleUseCase(getIt()));
  getIt.registerLazySingleton(() => SignInWithFacebookUseCase(getIt()));

  getIt.registerLazySingleton(() => ResetPasswordUseCase(getIt()));

  /// dataSources
  getIt.registerLazySingleton<AuthenticationDataSource>(
      () => AuthenticationDataSourceImpl(getIt()));

  /////////////////Courses feature//////////////////
  ///Bloc
  getIt.registerFactory(() => CoursesBloc(
        getCoursesByCategoryUseCase: getIt(),
        getTopRatedCoursesUseCase: getIt(),
        // getCourseDetailsUseCase: getIt(),
        getCoursesBySearchUseCase: getIt(),
      ));

  /// repository
  getIt.registerLazySingleton<CoursesRepository>(
      () => CoursesRepositoryImpl(getIt(), getIt()));

  ///useCases
  // getIt.registerLazySingleton(() => GetCourseDetailsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCoursesByCategoryUseCase(getIt()));
  getIt.registerLazySingleton(() => GetTopRatedCoursesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCoursesBySearchUseCase(getIt()));

  /// dataSources
  getIt.registerLazySingleton<CoursesDataSource>(() => CoursesDataSourceImpl());

  ////////////////////////Favorites feature///////////////////////////////
  ///Bloc
  getIt.registerFactory(() => FavoritesBloc(
      addCourseToFavoriresUseCase: getIt(),
      getFavoriteCoursesUseCase: getIt()));

  /// repository
  getIt.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(getIt()));

  /// dataSources
  getIt.registerLazySingleton<FavoritesDataSource>(
      () => FavoritesDataSourceImpl());

  ///useCases
  getIt.registerLazySingleton(() => AddCourseToFavoriresUseCase(getIt()));
  getIt.registerLazySingleton(() => GetFavoriteCoursesUseCase(getIt()));
  //////////////////////Profile feature/////////////////////////
  ///bloc
  getIt.registerFactory(() => ProfileBloc(
        uploadProfileImageUsecase: getIt(),
        signOutUseCase: getIt(),
        getUserDataUseCase: getIt(),
      ));

  /// repository
  getIt.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(getIt(), getIt()));

  /// dataSources
  getIt.registerLazySingleton<ProfileDataSource>(() => ProfileDataSourceImpl());

  ///useCases
  getIt.registerLazySingleton(() => UploadProfileImageUsecase(getIt()));
  getIt.registerLazySingleton(() => SignOutUseCase(getIt()));
  getIt.registerLazySingleton(() => GetUserDataUseCase(getIt()));
  //////////////////////Chat feature////////////////////////////
  ///bloc
  getIt.registerFactory(() => ChatBloc(
        sendMessageUseCase: getIt(),
        getMessageUseCase: getIt(),
        sendVoiceMessageUseCase: getIt(),
        // getVoiceMessageUseCase: getIt(),
      ));

  /// repository
  getIt.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(getIt(), getIt()));

  /// dataSources
  getIt.registerLazySingleton<ChatDataSource>(() => ChatDataSourceImpl());

  ///useCases
  getIt.registerLazySingleton(() => SendMessageUseCase(getIt()));
  getIt.registerLazySingleton(() => GetMessageUseCase(getIt()));
  getIt.registerLazySingleton(() => SendVoiceMessageUseCase(getIt()));
  // getIt.registerLazySingleton(() => GetVoiceMessageUseCase(getIt()));
  ////////////////////////Payment Feature///////////////////////
  ///bloc
  getIt.registerFactory(() => PaymentBloc(
      addCourseToBookedCoursesUseCase: getIt(),
      requestPaymentAuthUseCase: getIt(),
      requestOrderUseCase: getIt(),
      requestPaymentUseCase: getIt()));

  ///repository
  getIt.registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(getIt(), getIt()));

  /// dataSources
  getIt.registerLazySingleton<PaymentDataSource>(
      () => PaymentDataSourceImpl(getIt()));

  ///useCases
  getIt.registerLazySingleton(() => RequestPaymentAuthUseCase(getIt()));
  getIt.registerLazySingleton(() => RequestOrderUseCase(getIt()));
  getIt.registerLazySingleton(() => RequestPaymentUseCase(getIt()));
  getIt.registerLazySingleton(() => AddCourseToBookedCoursesUseCase(getIt()));
//////////////////////////////Content Feature///////////////////////////
  ///bloc
  getIt.registerFactory(() => ContentBloc(
        //getCourseVideosUseCase: getIt(),
        playVideoUseCase: getIt(),
        getBookedCoursesUseCase: getIt(),
      ));

  ///repository
  getIt.registerLazySingleton<ContentRepository>(
      () => ContentRepositoryImpl(getIt(), getIt()));

  /// dataSources
  getIt.registerLazySingleton<ContentDataSource>(() => ContentDataSourceImpl());

  ///useCases
  //getIt.registerLazySingleton(() => GetCourseVideosUseCase(getIt()));
  getIt.registerLazySingleton(() => PlayVideoUseCase(getIt()));
  getIt.registerLazySingleton(() => GetBookedCoursesUseCase(getIt()));
  ///////////////////////core///////////////////////////////////
  getIt.registerLazySingleton<InternetConnection>(
      () => InternetConnectionImpl(getIt()));
/////////////////////////Rating Featue/////////////////////////
  ///bloc
  getIt.registerFactory(() => RatingBloc(
        addRatingUseCase: getIt(),
        getRatingUseCase: getIt(),
      ));

  ///repository
  getIt.registerLazySingleton<RatingRepository>(
      () => RatingRepositoryImpl(getIt(), getIt()));

  /// dataSources
  getIt.registerLazySingleton<RatingDataSource>(() => RatingDataSourceImpl());

  ///useCases
  getIt.registerLazySingleton(() => AddRatingUseCase(getIt()));
  getIt.registerLazySingleton(() => GetRatingUseCase(getIt()));
/////////////////////////Community Featue/////////////////////////
  ///bloc
  getIt.registerFactory(() => CommunityBloc(
        addPostUseCase: getIt(),
        getPostsUseCase: getIt(),
        addLikeUseCase: getIt(),
        addCommentUseCase: getIt(),
        uploadPostImageUsecase: getIt(),
        getCommentsUseCase: getIt(),
      ));

  ///repository
  getIt.registerLazySingleton<CommunityRepository>(
      () => CommunityRepositoryImpl(getIt(), getIt()));

  /// dataSources
  getIt.registerLazySingleton<CommunityDataSource>(
      () => CommunityDataSourceImpl());

  ///useCases
  getIt.registerLazySingleton(() => AddPostUseCase(getIt()));
  getIt.registerLazySingleton(() => GetPostsUseCase(getIt()));
  getIt.registerLazySingleton(() => AddLikeUseCase(getIt()));
  getIt.registerLazySingleton(() => AddCommentUseCase(getIt()));
  getIt.registerLazySingleton(() => UploadPostImageUsecase(getIt()));
  getIt.registerLazySingleton(() => GetCommentsUseCase(getIt()));

  /////////////////////////External/////////////////////////////
  final sharedPrefrences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPrefrences);

  getIt.registerLazySingleton(() => InternetConnectionChecker());

  getIt.registerLazySingleton(() => DioHelper());

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  getIt.registerLazySingleton(() => firebaseAuth);

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  getIt.registerLazySingleton(() => firebaseFirestore);
}
