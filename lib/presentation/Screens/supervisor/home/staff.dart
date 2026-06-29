// ignore_for_file: file_names, deprecated_member_use

import 'package:facility_management/presentation/Screens/supervisor/home/staffplanner.dart';
import 'package:facility_management/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffTasksPage extends StatefulWidget {
  const StaffTasksPage({super.key});

  @override
  State<StaffTasksPage> createState() => _StaffTasksPageState();
}

class _StaffTasksPageState extends State<StaffTasksPage> {
  final List<Map<String, dynamic>> staffList = [
    {
      'name': 'Maria Santos',
      'code': '10 Required Tasks',
      'location': 'Deck 8 (A10109)',
      'task': 'Clean Public Area',
      'startTime': '14:00',
      'endTime': '15:00',
      'timeText': 'Started 5:42:30 PM',
      'status': 'In Progress',
      'statusColor': const Color(0xFF1976D2),
      'statusBg': const Color(0xFFE3F2FD),
      'comment': 'Started at 14:05, ongoing.',
      'avatar': 'https://randomuser.me/api/portraits/men/1.jpg',
      'isDetailsClicked': false,
    },
    {
      'name': 'Jack Smith',
      'code': '12 Required Tasks',
      'location': 'Deck B (REFA5)',
      'task': 'Inspect Equipment',
      'startTime': '13:30',
      'endTime': '15:30',
      'timeText': 'Started 9:02:30 AM',
      'status': 'Overdue',
      'statusColor': const Color(0xFFD32F2F),
      'statusBg': const Color(0xFFFFEBEE),
      'comment': 'Delayed due to parts shortage.',
      'avatar': 'https://randomuser.me/api/portraits/men/11.jpg',
      'isDetailsClicked': false,
    },
    {
      'name': 'Mike Johnson',
      'code': '11 Required Tasks',
      'location': 'Deck C (A53)',
      'task': 'Sweep Floor',
      'startTime': '14:30',
      'endTime': '15:15',
      'timeText': 'Started 7:10:30 PM',
      'status': 'Completed',
      'statusColor': const Color(0xFF388E3C),
      'statusBg': const Color(0xFFE8F5E9),
      'comment': 'Finished at 15:10.',
      'avatar': 'https://randomuser.me/api/portraits/men/3.jpg',
      'isDetailsClicked': false,
    },
    {
      'name': 'Maria Santos',
      'code': '10 Required Tasks',
      'location': 'Deck 8 (A1019)',
      'task': 'Clean Public Area',
      'startTime': '14:00',
      'endTime': '15:00',
      'timeText': 'Started 5:42:30 PM',
      'status': 'Overdue',
      'statusColor': const Color(0xFFD32F2F),
      'statusBg': const Color(0xFFFFEBEE),
      'comment': 'Task assignment delayed.',
      'avatar': 'https://randomuser.me/api/portraits/men/2.jpg',
      'isDetailsClicked': false,
    },
  ];
  bool showPlanner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            if (showPlanner) {
              setState(() => showPlanner = false);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'Staffs',
          style: GoogleFonts.lato(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined, color: Colors.black87),
            onPressed: () => setState(() => showPlanner = !showPlanner),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: InkWell(
                onTap: () {},
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
            color: const Color(0xFF2C3E94).withOpacity(0.15),
            height: 1.5,
          ),
        ),
      ),
      body:
          showPlanner
              ?  StaffPlannerScreen()
              : Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SearchBarWidget(
                      onPressed: () {},
                      hinttext: 'Search Staffs or Rooms',
                      controller: TextEditingController(),
                      bgColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: staffList.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final staff = staffList[index];
                        return _buildModernStaffCard(staff, index);
                      },
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _buildModernStaffCard(Map<String, dynamic> staff, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(staff['avatar']),
                  backgroundColor: Colors.grey.shade200,
                  onBackgroundImageError: (exception, stackTrace) {
                    debugPrint('Error loading avatar: $exception');
                  },
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        staff['name'],
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        staff['code'],
                        style: GoogleFonts.lato(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              staff['location'],
                              style: GoogleFonts.lato(
                                fontSize: 13,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          size: 14,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          staff['timeText'].toString().replaceAll('Started ', ''),
                          style: GoogleFonts.lato(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: staff['statusBg'],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        staff['status'],
                        style: GoogleFonts.lato(
                          fontSize: 11,
                          color: staff['statusColor'],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            if (staff['isDetailsClicked']) ...[
              const SizedBox(height: 12),
              const Divider(color: Color(0xFFF0F4F8)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Task: ${staff['task']}',
                    style: GoogleFonts.lato(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '${staff['startTime']} - ${staff['endTime']}',
                    style: GoogleFonts.lato(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        staff['comment'],
                        style: GoogleFonts.lato(fontSize: 13, color: Colors.grey.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 16),

            /// Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        staff['isDetailsClicked'] = !staff['isDetailsClicked'];
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2C3E94),
                      side: const BorderSide(color: Color(0xFF2C3E94)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      staff['isDetailsClicked'] ? 'Hide Details' : 'View Details',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C3E94),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Message',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

