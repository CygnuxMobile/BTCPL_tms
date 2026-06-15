import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionService {
  static final ConnectionService _instance = ConnectionService._internal();

  factory ConnectionService() => _instance;

  ConnectionService._internal();

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionChangeController = StreamController<bool>.broadcast();

  Stream<bool> get connectionChange => _connectionChangeController.stream;

  bool hasConnection = false;

  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChanged);
    _checkInitialConnection();
  }

  Future<void> _checkInitialConnection() async {
    final resultList = await _connectivity.checkConnectivity();
    _updateConnectionStatus(resultList);
  }

  void _connectionChanged(List<ConnectivityResult> resultList) {
    _updateConnectionStatus(resultList);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    bool previousConnection = hasConnection;

    hasConnection = result != ConnectivityResult.none;

    if (hasConnection != previousConnection) {
      _connectionChangeController.add(hasConnection);
    }
  }

  void dispose() {
    _connectionChangeController.close();
  }
}
