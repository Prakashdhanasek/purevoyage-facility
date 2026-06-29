import 'package:facility_management/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FMButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final TextStyle labelStyle;
  final Color bgColor;
  final double? verticalPadding;
  final double? height;
  final double? borderRadius;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final Color? borderColor;
  final double? horizontalPadding;
  final bool isLoading;
  const FMButton({
    super.key,
    required this.bgColor,
    this.borderRadius,
    this.height,
    required this.label,
    required this.labelStyle,
    this.onPressed, // No longer required, can be null
    this.verticalPadding,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.borderColor,
    this.horizontalPadding,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Now accepts VoidCallback?
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 8,
          horizontal: horizontalPadding ?? 24,
        ),
        height: height ?? 48,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: borderColor ?? AppColors.fmBlue700,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 6),
          color: bgColor,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(icon, color: iconColor ?? Colors.white, size: iconSize),
                const SizedBox(width: 8),
              ],
              Text(label, style: labelStyle),
            ],
          ),
        ),
      ),
    );
  }
}
