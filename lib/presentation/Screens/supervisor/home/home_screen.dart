// ignore_for_file: deprecated_member_use

import 'package:facility_management/core/constants/assets_paths.dart';
import 'package:facility_management/widgets/fm_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSupervisorPage extends StatelessWidget {
  const HomeSupervisorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textScaler = MediaQuery.of(context).textScaler;

    return Scaffold(
      appBar: const FMAppBar(),
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(size.width * 0.04), // 4% of screen width
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.012),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning, Martin Richard',
                        style: GoogleFonts.lato(
                          fontSize: textScaler.scale(20),
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Supervisor',
                        style: GoogleFonts.lato(
                          fontSize: textScaler.scale(14),
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02), // 2% of screen height
            _buildStatCards(context, size),
            SizedBox(height: size.height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image.asset(
                    AssetsPathConstants.recentactivityImagepath,
                    height: 48,
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.015),
            // Task tiles matching mockup exactly
            _buildTaskTile(
              context,
              'Cabin B-156',
              'Maria Santos',
              'Pending',
              'Just Assigned',
              const Color(0xFFF57C00),
              const Color(0xFFFFF3E0),
            ),
            _buildTaskTile(
              context,
              'Deck 5 Lounge',
              'Johnson Smith',
              'In Progress',
              '2 min ago',
              const Color(0xFF1976D2),
              const Color(0xFFE3F2FD),
            ),
            _buildTaskTile(
              context,
              'Cabin A-204',
              'Mike Tyson',
              'Completed',
              '2hrs ago',
              const Color(0xFF388E3C),
              const Color(0xFFE8F5E9),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCards(BuildContext context, Size size) {
    return Column(
      children: [
        Row(
          children: [
            _buildStatCard(
              context,
              'Active Staff',
              '56',
              AssetsPathConstants.staffFillImagePath,
              size,
            ),
            const SizedBox(width: 12),
            _buildStatCard(
              context,
              'Critical Alerts',
              '06',
              AssetsPathConstants.overDueTaskImagPath,
              size,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildStatCard(
              context,
              'In Progress',
              '12',
              AssetsPathConstants.inprogressImagePath,
              size,
            ),
            const SizedBox(width: 12),
            _buildStatCard(
              context,
              'Resolved Today',
              '24',
              AssetsPathConstants.resolvedImagePath,
              size,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    String imgPath,
    Size size,
  ) {
    final textScaler = MediaQuery.of(context).textScaler;

    return Expanded(
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFF0F4F8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lato(
                      fontSize: textScaler.scale(12),
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: GoogleFonts.lato(
                      fontSize: textScaler.scale(22),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(imgPath, height: 32, width: 32, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskTile(
    BuildContext context,
    String title,
    String subtitle,
    String status,
    String assignedStatus,
    Color textColor,
    Color bgColor,
  ) {
    final size = MediaQuery.of(context).size;
    final textScaler = MediaQuery.of(context).textScaler;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.016,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFF0F4F8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: textScaler.scale(16),
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.lato(
                      fontSize: textScaler.scale(13),
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    assignedStatus,
                    style: GoogleFonts.lato(
                      fontSize: textScaler.scale(11),
                      color: Colors.grey.shade400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                status,
                style: GoogleFonts.lato(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: textScaler.scale(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

