import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/data/providers/global_provider.dart';
import 'package:facility_management/services/connectivity_service.dart';
import 'package:facility_management/widgets/fm_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FMLandingPage extends StatefulWidget {
  const FMLandingPage({super.key});

  @override
  State<FMLandingPage> createState() => _FMLandingPageState();
}

class _FMLandingPageState extends State<FMLandingPage>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, String>> yachts = <Map<String, String>>[
    <String, String>{'name': 'Odessey', 'subtitle': 'Unnamed Vessel'},
    <String, String>{'name': 'M/Y . Yacht3'},
    <String, String>{'name': 'Royal Crest'},
  ];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!mounted) return;
      ConnectivityService().checkConnection(context);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    if (!mounted) return;
    ConnectivityService().checkConnection(context);

    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, provider, _) {
        final isStaff = provider.selectedRoleInLogin == 'staff';

        return Scaffold(
          backgroundColor: AppColors.fmBackground,
          key: _scaffoldKey,
          body: PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, dynamic result) {
              provider.backNavigation(context);
            },
            child: Center(child: provider.getStaffSelectedScreen()),
          ),
          bottomNavigationBar: const FMBottomBar(),
          floatingActionButton: isStaff
              ? SizedBox(
                  height: 64,
                  width: 64,
                  child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: const Color(0xFF2C3E94),
                    elevation: 6,
                    shape: const CircleBorder(
                      side: BorderSide(color: Colors.white, width: 4),
                    ),
                    child: const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                )
              : null,
          floatingActionButtonLocation: isStaff
              ? FloatingActionButtonLocation.centerDocked
              : null,
        );
      },
    );
  }
}
