// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:facility_management/core/utils/common_utils.dart';
import 'package:facility_management/data/storage/user_controller.dart';
import 'package:facility_management/services/network_connectivity_status.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  StreamSubscription<NetworkStatus>? streamSub;
  final Stream<NetworkStatus> _stream =
      NetworkStatusService.networkStatusController.stream;

  checkConnection(BuildContext context) {
    streamSub = _stream.listen((NetworkStatus status) async {
      UserController().networkStatus = status;
      if (status == NetworkStatus.Online) {
        showSuccessSnack(context, 'Internet connection restored');
        await Future.delayed(const Duration(milliseconds: 1000));
      } else if (status == NetworkStatus.Offline) {
        showErrorSnack(context, 'Internet connection lost');
      }
    });
    checkInternetConnection(context);
  }

  checkInternetConnection(BuildContext context) async {
    try {
      List<NetworkInterface> deviceIp = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
      );
      if (deviceIp.isEmpty) {
        throw const SocketException('No Internet Connection');
      }
      return;
    } on SocketException catch (_) {
      showErrorSnack(context, 'No internet connection');
    }
  }
}
