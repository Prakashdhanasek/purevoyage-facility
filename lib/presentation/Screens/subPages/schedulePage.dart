// ignore_for_file: file_names

import 'package:facility_management/presentation/Screens/subPages/notificationDrawer.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:facility_management/app/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Map<String, dynamic>> scheduleTasks = [
    {
      'title': 'Cabin B-156',
      'task': 'Empty trash bins',
      'time': '09:00 AM',
      'date': '17/08/2025',
    },
    {
      'title': 'Cabin B-156',
      'task': 'Mop floors with disinfectant',
      'time': '10:30 AM',
      'date': '17/08/2025',
    },
    {
      'title': 'Cabin D-946',
      'task': 'Check and refill toilet paper',
      'time': '11:20 AM',
      'date': '17/08/2025',
    },
  ];
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
          'Schedule',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTodaySchedule(),
            _buildCalendar(),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children:
                    scheduleTasks.map((task) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _buildTaskCard(task),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaySchedule() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today Schedule',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Please Complete the Required Tasks',
                style: GoogleFonts.lato(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.fmBlue50,
            ),
            child: Text(
              '3 Decks',
              style: GoogleFonts.lato(
                color: AppColors.fmBlue950,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TableCalendar(
          firstDay: DateTime.utc(2020),
          lastDay: DateTime.utc(2030),
          focusedDay: _focusedDay,
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate:
              (day) => isSameDay(_selectedDay ?? _focusedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
            leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.black54),
            rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.black54),
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              border: Border.all(color: AppColors.fmBlue950.withValues(alpha: 0.3)),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
            selectedDecoration: BoxDecoration(
              border: Border.all(color: AppColors.fmBlue950, width: 1.5),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
            defaultDecoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
            weekendDecoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
            outsideDecoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
            todayTextStyle: GoogleFonts.lato(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            selectedTextStyle: GoogleFonts.lato(
              color: AppColors.fmBlue950,
              fontWeight: FontWeight.bold,
            ),
            defaultTextStyle: GoogleFonts.lato(color: Colors.black87),
            weekendTextStyle: GoogleFonts.lato(color: Colors.black87),
            outsideTextStyle: GoogleFonts.lato(color: Colors.grey.shade400),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
            weekendStyle: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              color: AppColors.fmBlue900,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.fmBlue50),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task['title'],
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  task['task'],
                  style: GoogleFonts.lato(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  task['date'],
                  style: GoogleFonts.lato(
                    fontSize: 11,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          Text(
            task['time'],
            style: GoogleFonts.lato(
              color: AppColors.fmBlue950,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

