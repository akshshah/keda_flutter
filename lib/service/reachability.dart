import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../utils/logger.dart';

class Reachability extends Object {

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  // current network status
  String _connectStatus = 'Unknown';
  String get connectStatus => _connectStatus;

  //Constant for check network status
  static const String _connectivityMobile = "ConnectivityResult.mobile";
  static const String _connectivityWifi = "ConnectivityResult.wifi";

  factory Reachability() {
    return _singleton;
  }

  static final Reachability _singleton = Reachability._internal();
  Reachability._internal() {
    connectivitySubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectStatus = result.toString();
      Logger().v("ConnectionStatus :: = $_connectStatus");
    });
  }

  dispose() {
    connectivitySubscription?.cancel();
  }


  // set up initial
  Future<void> setUpConnectivity() async {
    String connectionStatus;

    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
      Logger().v("ConnectionStatus :: => $connectionStatus");
    } on Exception catch (e) {
      Logger().e(e.toString());
      connectionStatus = 'Failed to get connectivity.';
    }
    _connectStatus = connectionStatus;
    Logger().v("ConnectionStatus :: => $_connectStatus");
  }

  // check for network available
  bool isInterNetAvailable() {
    Logger().v("ConnectionStatus :: => $_connectStatus");
    return (_connectStatus == Reachability._connectivityMobile) || (_connectStatus == Reachability._connectivityWifi);
  }

}