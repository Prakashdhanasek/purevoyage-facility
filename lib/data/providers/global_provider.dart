// ignore_for_file: avoid_print

import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/core/constants/role.dart';
import 'package:facility_management/core/utils/custom_route.dart';
import 'package:facility_management/presentation/Screens/login_screen.dart';
import 'package:facility_management/presentation/Screens/subPages/homePage.dart';
import 'package:facility_management/presentation/Screens/subPages/profilePage.dart';
import 'package:facility_management/presentation/Screens/subPages/schedulePage.dart';
import 'package:facility_management/presentation/Screens/subPages/taskPage.dart';
import 'package:facility_management/presentation/Screens/supervisor/svLandingPage.dart';
import 'package:facility_management/widgets/common_bottom_sheet.dart';
import 'package:facility_management/widgets/fm_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../presentation/Screens/supervisor/home/staff.dart';
import '../../presentation/Screens/supervisor/home/task.dart';

class GlobalProvider extends ChangeNotifier {
  GlobalProvider() {
    getAllContriesRequest();
    getAllLanguagesRequest();
    getAllCurrencyRequest();
  }
  String selectedRoleInLogin = 'staff';

  void setSelectedRole(String role) {
    selectedRoleInLogin = role;
    notifyListeners();
  }

  int selectedIndex = 0;
  void setSelectedIndex(int index) {
    selectedIndex = index;

    notifyListeners();
  }

  int drawerCurrentIndex = 0;
  int drawerPurserCurrentIndex = 0;
  int currentIndex = 0;
  int financeIndex = -1;
  int tripSubIndex = -1;
  int crewSubIndex = -1;

  int crewPurserSubIndex = -1;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  void changeIndex(int indexValue) {
    currentIndex = indexValue;
    notifyListeners();
  }

  void changeSubIndex(String main, int index) {
    notifyListeners();
  }

  void changeDrawerIndex(int indexValue) {
    drawerCurrentIndex = indexValue;
    notifyListeners();
  }

  void changePurserDrawerIndex(int indexValue) {
    drawerPurserCurrentIndex = indexValue;
    notifyListeners();
  }

  int selectedPageIndex = 0;

  Widget getStaffSelectedScreen() {
    if (selectedRoleInLogin == 'staff') {
      switch (selectedPageIndex) {
        case 0:
          return HomePage();
        case 1:
          return const TaskPage();
        case 2:
          return const SchedulePage();
        case 3:
          return const ProfilePage();
      }
    } else {
      switch (selectedPageIndex) {
        case 0:
          return const Svlandingpage();
        case 1:
          return const TaskSupervisorPage();
        case 2:
          return const StaffTasksPage();
        case 3:
          return const ProfilePage();
      }
    }
    return const Placeholder();
  }

  void updateStaffPage(int index) {
    selectedPageIndex = index;
    notifyListeners();
  }

  void updateSuperVisorPage(int index) {
    selectedPageIndex = index;
    notifyListeners();
  }

  void backNavigation(BuildContext context) {
    if (currentIndex == 0) {
      customShowModalBottomSheet(
        context: context,
        inputWidget: CommonBottomSheet(
          negativeTxt: 'No',
          postiveBtnClr: AppColors.fmBlue900,
          positiveOnPress: () async {
            Navigator.of(context).pushReplacement(
              CustomRoute<MaterialPageRoute>(builder: (_) => LoginScreen()),
            );
          },
          negativePress: () {
            Navigator.of(context).pop(true);
          },
          title: 'Are you sure you want to exit?',
        ),
      );
    } else {
      changeDrawerIndex(0);
      changeIndex(0);
      if (RoleData.selectedRoleName == 'staff') {
        updateStaffPage(0);
      } else {
        updateSuperVisorPage(0);
      }
    }
    notifyListeners();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Draft':
        return Colors.orange.shade100;
      case 'Outstanding':
        return Colors.red.shade100;
      case 'Paid':
        return Colors.green.shade100;
      default:
        return Colors.grey;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status) {
      case 'Draft':
        return Colors.orange;
      case 'Outstanding':
        return Colors.red;
      case 'Paid':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  getAllContriesRequest() async {
    try {
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  getAllCurrencyRequest() async {
    try {
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  getAllLanguagesRequest() async {
    try {
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
