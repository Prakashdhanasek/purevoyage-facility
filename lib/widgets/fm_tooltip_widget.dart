import 'package:facility_management/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FMToolTip extends StatelessWidget {
  final String showMessage;
  final Widget child;
  final bool showAbove;
  final double verticalOffset;
  const FMToolTip({
    super.key,
    required this.showMessage,
    required this.child,
    this.verticalOffset = 24,
    this.showAbove = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: showMessage,
      verticalOffset: showAbove ? (-1 * verticalOffset) : verticalOffset,
      decoration: BoxDecoration(
        color: AppColors.fmBlue700,
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }
}
