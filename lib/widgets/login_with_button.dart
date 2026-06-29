import 'package:facility_management/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoginWithButton extends StatelessWidget {
  final Function() onClicked;
  final String imgPath;
  const LoginWithButton({
    super.key,
    required this.onClicked,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.backgroundTertiary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(imgPath, height: 18, width: 18),
      ),
    );
  }
}
