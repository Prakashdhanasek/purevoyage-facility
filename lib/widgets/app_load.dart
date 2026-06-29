import 'package:facility_management/core/constants/assets_paths.dart'
    show AssetsPathConstants;
import 'package:flutter/material.dart';

class AppMiniLoader extends StatelessWidget {
  const AppMiniLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(AssetsPathConstants.fmLogoPath, height: 40),
            SizedBox(height: 12),
            const CircularProgressIndicator(
              color: Color(0xFF0052A5), // Use mariner blue
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
