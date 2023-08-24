import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class InternetConnection {
  Future<bool> get isInternetConnected;
}

class InternetConnectionImpl implements InternetConnection {
  final InternetConnectionChecker connectionChecker;

  InternetConnectionImpl(this.connectionChecker);

  @override
  Future<bool> get isInternetConnected => connectionChecker.hasConnection;
}
