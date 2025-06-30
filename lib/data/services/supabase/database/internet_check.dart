import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionStatusController =
      StreamController<bool>.broadcast();

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((result) {
      _checkConnection(result as ConnectivityResult);
    });
    _initialize();
  }

  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  Future<void> _initialize() async {
    var result = await _connectivity.checkConnectivity();
    _checkConnection(result as ConnectivityResult);
  }

  void _checkConnection(ConnectivityResult result) {
    bool isConnected = result != ConnectivityResult.none;
    _connectionStatusController.sink.add(isConnected);
  }

  void dispose() {
    _connectionStatusController.close();
  }
}
