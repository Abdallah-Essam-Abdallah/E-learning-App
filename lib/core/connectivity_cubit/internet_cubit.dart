import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit() : super(InternetInitial());
  StreamSubscription? internetSubscription;

  void checkInternetConnection() {
    internetSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(ConnectedInternetState());
      } else {
        emit(DisconnectedInternetState());
      }
    });
  }

  @override
  Future<void> close() {
    internetSubscription!.cancel();
    return super.close();
  }
}
