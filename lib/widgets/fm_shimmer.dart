import 'package:facility_management/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FacilityManagementShimmer extends StatelessWidget {
  final double height;
  final double width;
  const FacilityManagementShimmer({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
        baseColor: AppColors.backgroundTertiary,
        highlightColor: AppColors.backgroundQuaternary,
        direction: ShimmerDirection.ltr,
        period: const Duration(milliseconds: 500),
        enabled: true,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.backgroundQuaternary,
          ),
          width: width,
        ),
      ),
    );
  }
}
