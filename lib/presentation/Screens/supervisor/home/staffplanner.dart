import 'package:flutter/material.dart';
import '../../../../widgets/common_app_bar.dart';
import '../../../../widgets/fm_bottom_bar.dart';

class StaffPlannerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _schedules = [
    {
      'name': 'Jack Smith',
      'area': 'Main Dining Area',
      'start': 6,
      'end': 7,
      'color': Colors.red[100],
      'avatarUrl': 'https://randomuser.me/api/portraits/men/1.jpg',
    },
    {
      'name': 'Maria Santos',
      'area': 'Deck 8',
      'start': 10,
      'end': 11,
      'color': Colors.blue[100],
      'avatarUrl': 'https://randomuser.me/api/portraits/women/2.jpg',
    },
    {
      'name': 'Mike Johnson',
      'area': 'Deck C(A53)',
      'start': 12,
      'end': 14,
      'color': Colors.green[100],
      'avatarUrl': 'https://randomuser.me/api/portraits/men/3.jpg',
    },
  ];

  StaffPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> hours = List.generate(12, (index) => 6 + index); // 6 AM to 5 PM

    return Scaffold(

      body: Column(
        children: [
          _buildDateHeader(),
          Expanded(
            child: Row(
              children: [
                _buildTimeColumn(hours),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: 300, // Width for the timeline column
                      child: ListView.builder(
                        itemCount: hours.length,
                        itemBuilder: (context, index) {
                          final hour = hours[index];
                          final schedule = _schedules.firstWhere(
                                (s) => hour >= s['start'] && hour < s['end'],
                            orElse: () => {},
                          );

                          if (schedule.isNotEmpty) {
                            return Container(
                              height: 80,
                              margin: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: schedule['color'],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(schedule['avatarUrl']),
                                    backgroundColor: Colors.grey.shade300,
                                    onBackgroundImageError: (exception, stackTrace) {
                                      debugPrint('Error loading avatar: $exception');
                                    },
                                    child: const Icon(Icons.person, color: Colors.white),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          schedule['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        // Optional divider between name and area
                                        // const Divider(
                                        //   height: 8,
                                        //   thickness: 1,
                                        //   color: Colors.grey,
                                        // ),
                                        Text(
                                          schedule['area'],
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const Divider(
                                          height: 8,
                                          thickness: 1,
                                          color: Colors.grey, // Matches TaskSupervisorPage
                                        ),
                                        Text(
                                          '${_formatTime(schedule['start'])} - ${_formatTime(schedule['end'])}',
                                          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              height: 80,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('${_formatTime(hour)}'),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }

  Widget _buildDateHeader() {
    List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    List<String> dates = ['10', '11', '12', '13', '14', '15', '16'];

    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          bool isSelected = days[index] == 'Wed';
          return Container(
            width: 60,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            decoration: BoxDecoration(
              border: Border(
                bottom: isSelected
                    ? const BorderSide(color: Colors.blue, width: 3)
                    : BorderSide.none,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  days[index],
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                Text(dates[index], style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeColumn(List<int> hours) {
    return Container(
      width: 70,
      child: ListView.builder(
        itemCount: hours.length,
        itemBuilder: (context, index) {
          final hour = hours[index];
          return Container(
            height: 80,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _formatTime(hour),
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          );
        },
      ),
    );
  }

  String _formatTime(int hour) {
    final suffix = hour >= 12 ? 'pm' : 'am';
    final displayHour = hour > 12 ? hour - 12 : hour == 0 ? 12 : hour;
    return '$displayHour:00 $suffix';
  }
}