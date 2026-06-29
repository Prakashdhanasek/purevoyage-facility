// ignore_for_file: file_names

import 'package:facility_management/core/utils/custom_route.dart';
import 'package:facility_management/data/providers/global_provider.dart';
import 'package:facility_management/presentation/Screens/login_screen.dart';
import 'package:facility_management/presentation/Screens/subPages/notificationDrawer.dart';
import 'package:flutter/material.dart';
import 'package:facility_management/core/constants/assets_paths.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Profile',
          style: GoogleFonts.lato(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: InkWell(
                onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.black87,
                      size: 28,
                    ),
                    Positioned(
                      right: 2,
                      top: 2,
                      child: Container(
                        height: 9,
                        width: 9,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(
            color: const Color(0xFF2C3E94).withValues(alpha: 0.15),
            height: 1.5,
          ),
        ),
      ),
      endDrawer: const NotificationDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildStatsGrid(),
            const SizedBox(height: 30),
            _buildListOptions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F4F8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildUserDetails(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE2F6EA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "Active",
              style: GoogleFonts.lato(
                color: const Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetails() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(
            AssetsPathConstants.dummyProfileImagePath,
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Velto Renari',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Task Performer",
              style: GoogleFonts.lato(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            _buildStatCard(
              'Completed Tasks',
              '243',
              AssetsPathConstants.completedTaskImagPath,
            ),
            const SizedBox(width: 12),
            _buildStatCard(
              'Overdue Tasks',
              '12',
              AssetsPathConstants.overDueTaskImagPath,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildStatCard(
              'Efficiency',
              '98%',
              AssetsPathConstants.upcomingTaskImagPath,
            ),
            const SizedBox(width: 12),
            _buildStatCard(
              'Hours Worked',
              '875Hrs',
              AssetsPathConstants.timeOnDutyImagPath,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String imgPath) {
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
              color: Colors.black.withValues(alpha: 0.02),
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
                      fontSize: 12,
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
                      fontSize: 22,
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
            Image.asset(imgPath, height: 35),
          ],
        ),
      ),
    );
  }

  Widget _buildListOptions(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          leading: const Icon(Icons.lock_outline_rounded, color: Colors.black87),
          title: Text(
            "Change Password",
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.black87),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacement(
              CustomRoute<MaterialPageRoute>(builder: (_) => LoginScreen()),
            );
            final GlobalProvider globalProvider = Provider.of<GlobalProvider>(
              context,
              listen: false,
            );

            globalProvider.changeIndex(0);
            globalProvider.updateStaffPage(0);
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          leading: const Icon(Icons.logout_rounded, color: Colors.black87),
          title: Text(
            "Log out",
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.black87),
        ),
      ],
    );
  }
}

