import 'package:courses_app/core/chache_helper/chache_helper.dart';

import 'package:courses_app/core/network/dio_helper.dart';
import 'package:courses_app/core/theme/apptheme.dart';
import 'package:courses_app/features/authentication/presentation/controller/authentication_bloc/authentication_bloc.dart';
import 'package:courses_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:courses_app/features/community/presentation/controller/bloc/community_bloc.dart';

import 'package:courses_app/features/courses/presentation/screens/home_screen.dart';
import 'package:courses_app/features/onboarding/presentation/pages/onboarding.dart';
import 'package:courses_app/features/payment/presentation/controller/payment_bloc/payment_bloc.dart';
import 'package:courses_app/features/profile/presentation/controller/profile_bloc/profile_bloc.dart';
import 'package:courses_app/features/rating/presentation/controller/bloc/rating_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc_observer/bloc_observer.dart';
import 'core/connectivity_cubit/internet_cubit.dart';
import 'core/dependency_injection/injection.dart' as di;
import 'features/courses/presentation/controller/courses_bloc/courses_bloc.dart';
import 'features/favorites/presentation/favorites_bloc/favorites_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.sharedInit();
  await di.getitInit();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  final bool isOnboardingSkipped =
      CacheHelper.getBoolean(key: 'isOnboardingSkipped') ?? false;
  final bool isLoggedIn = CacheHelper.getBoolean(key: 'isLoggedIn') ?? false;

  Widget startWidget;
  if (isOnboardingSkipped) {
    if (isLoggedIn) {
      startWidget = const HomeScreen();
    } else {
      startWidget = const LogInScreen();
    }
  } else {
    startWidget = const OnBoardingScreen();
  }
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp(
    isOnboardingSkipped: isOnboardingSkipped,
    isLoggedIn: isLoggedIn,
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.isOnboardingSkipped,
      required this.isLoggedIn,
      required this.startWidget});
  final bool isOnboardingSkipped;
  final bool isLoggedIn;
  final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.getIt<AuthenticationBloc>()),
        BlocProvider(create: (context) => di.getIt<CoursesBloc>()),
        BlocProvider(create: (context) => di.getIt<ProfileBloc>()),
        BlocProvider(
            create: (context) => di.getIt<FavoritesBloc>()
              ..add(const GetFavoriteCoursesEvent())),
        BlocProvider(create: (context) => di.getIt<PaymentBloc>()),
        BlocProvider(create: (context) => di.getIt<RatingBloc>()),
        BlocProvider(create: (context) => di.getIt<CommunityBloc>()),
        BlocProvider(
            create: (context) => InternetCubit()..checkInternetConnection()),
      ],
      child: MaterialApp(
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          home: startWidget),
    );
  }
}
