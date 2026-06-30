import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facility_management/core/constants/assets_paths.dart';
import 'package:facility_management/data/providers/global_provider.dart';

class FMBottomBar extends StatelessWidget {
  const FMBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    final bool isStaff = provider.selectedRoleInLogin == 'staff';

    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      elevation: 12,
      shadowColor: Colors.black38,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    context,
                    'Home',
                    provider.currentIndex == 0
                        ? AssetsPathConstants.homeFillImagePath
                        : AssetsPathConstants.homeImagePath,
                    0,
                    provider,
                    isStaff,
                  ),
                  _buildNavItem(
                    context,
                    'Tasks',
                    provider.currentIndex == 1
                        ? AssetsPathConstants.tasksFillImagePath
                        : AssetsPathConstants.taskPath,
                    1,
                    provider,
                    isStaff,
                  ),
                ],
              ),
            ),
            // Notch Spacer
            const SizedBox(width: 60),
            // Right side
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    context,
                    isStaff ? 'Schedule' : 'Staffs',
                    isStaff
                        ? (provider.currentIndex == 2
                            ? AssetsPathConstants.scheduleFillImagePath
                            : AssetsPathConstants.scheduleImagePath)
                        : (provider.currentIndex == 2
                            ? AssetsPathConstants.staffFillImagePath
                            : AssetsPathConstants.staffImagePath),
                    2,
                    provider,
                    isStaff,
                  ),
                  _buildNavItem(
                    context,
                    'Profile',
                    provider.currentIndex == 3
                        ? AssetsPathConstants.profileFillImagePath
                        : AssetsPathConstants.profileImagePath,
                    3,
                    provider,
                    isStaff,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String label,
    String assetPath,
    int index,
    GlobalProvider provider,
    bool isStaff,
  ) {
    final bool isSelected = provider.currentIndex == index;
    final color = isSelected ? const Color(0xFF2C3E94) : const Color(0xFF666666);
    return InkWell(
      onTap: () {
        if (isStaff) {
          provider.updateStaffPage(index);
        } else {
          provider.updateSuperVisorPage(index);
        }
        provider.changeIndex(index);
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              color: color,
              height: 24,
              width: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

