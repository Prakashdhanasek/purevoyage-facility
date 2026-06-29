// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { Online, Offline }

class NetworkStatusService {
  static NetworkStatus currentStatus = NetworkStatus.Online;
  static StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>.broadcast();

  NetworkStatusService() {
    checkInternetAccess().then((NetworkStatus stat) {
      currentStatus = stat;
      Connectivity().onConnectivityChanged.listen((
        List<ConnectivityResult> statusList,
      ) {
        final ConnectivityResult primaryStatus =
            statusList.isNotEmpty ? statusList.first : ConnectivityResult.none;
        NetworkStatus stat = _getNetworkStatus(primaryStatus);
        if (currentStatus != stat) {
          currentStatus = stat;
          networkStatusController.add(stat);
        }
      });
    });
  }

  static Future<NetworkStatus> checkInternetAccess({String? domain}) async {
    try {
      List<NetworkInterface> deviceIp = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
      );
      if (deviceIp.isEmpty) return NetworkStatus.Offline;
      return NetworkStatus.Online;
    } on SocketException catch (_) {
      return NetworkStatus.Offline;
    }
  }

  static Future<bool> hasConnection({String domain = 'google.com'}) async {
    try {
      List<NetworkInterface> deviceIp = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
      );
      if (deviceIp.isEmpty) {
        throw const SocketException('No Internet Connection');
      }
      return true;
    } on SocketException catch (_) {
      return false;
    }
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    return (status == ConnectivityResult.mobile ||
            status == ConnectivityResult.wifi)
        ? NetworkStatus.Online
        : NetworkStatus.Offline;
  }
}
