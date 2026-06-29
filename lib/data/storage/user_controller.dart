import 'package:facility_management/services/network_connectivity_status.dart';

class UserController {
  UserController._privateConstructor();
  static final UserController userController =
      UserController._privateConstructor();

  factory UserController() {
    return userController;
  }

  NetworkStatus networkStatus = NetworkStatus.Online;

  bool uploadedDocument = false;
  bool jobsApplied = false;

  void dispose() {
    networkStatus = NetworkStatus.Online;
  }
}
