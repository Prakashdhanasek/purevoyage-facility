// ignore_for_file: file_names

import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/app/theme/app_text_styles.dart';
import 'package:facility_management/core/utils/custom_route.dart';
import 'package:facility_management/presentation/Screens/subPages/notificationDrawer.dart';
import 'package:facility_management/presentation/Screens/subPages/view_my_tasks.dart';
import 'package:facility_management/widgets/fm_app_bar.dart';
import 'package:facility_management/widgets/fm_button.dart';
import 'package:facility_management/widgets/fm_toggle_button.dart';
import 'package:facility_management/widgets/searchbar.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  int _selectedTabIndex = 0;
  late List<bool> _showMoreTasks;

  @override
  void initState() {
    super.initState();
    _showMoreTasks = List.generate(taskList.length, (index) => false);
  }

  final List<Map<String, dynamic>> _tabs = <Map<String, dynamic>>[
    <String, dynamic>{'option': 'All Tasks'},
    <String, dynamic>{'option': 'Upcoming'},
    <String, dynamic>{'option': 'Overdue'},
    <String, dynamic>{'option': 'Active'},
  ];
  List<Map<String, dynamic>> taskList = [
    {
      'title': 'Cabin B-156',
      'date': '17/08/2025',
      'status': 'In Progress',
      'statusColor': Colors.blue,
      'location': 'Deck 8',
      'duration': '1 Hour',
      'requiredTasks': 10,
      'tasks': [
        {'label': 'Empty trash bins', 'checked': false},
        {'label': 'Refill soap dispensers', 'checked': false},
        {'label': 'Clean mirrors', 'checked': false},
      ],
    },
    {
      'title': 'Cabin D-247',
      'date': '17/08/2025',
      'status': 'Upcoming',
      'statusColor': Colors.purple,
      'location': 'Deck 6',
      'duration': '30 mins',
      'requiredTasks': 8,
      'tasks': [
        {'label': 'Wipe surfaces', 'checked': false},
        {'label': 'Vacuum carpet', 'checked': false},
      ],
    },
    {
      'title': 'Hallway A-102',
      'date': '16/08/2025',
      'status': 'Completed',
      'statusColor': Colors.green,
      'location': 'Deck 2',
      'duration': '45 mins',
      'requiredTasks': 5,
      'tasks': [
        {'label': 'Sweep floor', 'checked': true},
        {'label': 'Disinfect handrails', 'checked': true},
        {'label': 'Polish tiles', 'checked': true},
      ],
    },
    {
      'title': 'Engine Room C-309',
      'date': '18/08/2025',
      'status': 'Overdue',
      'statusColor': Colors.red,
      'location': 'Deck 1',
      'duration': '1.5 Hours',
      'requiredTasks': 7,
      'tasks': [
        {'label': 'Degrease equipment', 'checked': false},
        {'label': 'Check oil leaks', 'checked': false},
        {'label': 'Clean floor mats', 'checked': false},
      ],
    },
    {
      'title': 'Pantry E-412',
      'date': '18/08/2025',
      'status': 'Active',
      'statusColor': Colors.orange,
      'location': 'Deck 3',
      'duration': '40 mins',
      'requiredTasks': 6,
      'tasks': [
        {'label': 'Clean shelves', 'checked': false},
        {'label': 'Sanitize handles', 'checked': false},
        {'label': 'Empty refrigerator', 'checked': false},
      ],
    },
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: FMAppBar(
        onLeadingTap: () {},
        actions: [
          InkWell(
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
        ],
      ),
      endDrawer: NotificationDrawer(),
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBarWidget(
              onPressed: () {},
              hinttext: 'Search Rooms',
              controller: TextEditingController(),
              bgColor: AppColors.backgroundPrimary,
            ),
            FMToggleButton(
              selectedIndex: _selectedTabIndex,
              onChangeSelected: (int index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              optionList: _tabs,
              selectedColor: AppColors.fmBlue950,
            ),
            SizedBox(height: 10),
            ...taskList.asMap().entries.map((entry) {
              final task = entry.value;
              final taskIndex = entry.key;

              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: _buildTaskCard(
                  title: task['title'],
                  date: task['date'],
                  status: task['status'],
                  statusColor: task['statusColor'],
                  location: task['location'],
                  duration: task['duration'],
                  requiredTasks: task['requiredTasks'],
                  tasks: task['tasks'],
                  taskIndex: taskIndex,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard({
    required String title,
    required String date,
    required String status,
    required Color statusColor,
    required String location,
    required String duration,
    required int requiredTasks,
    required List<Map<String, dynamic>> tasks,
    required int taskIndex,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      "$requiredTasks Required Tasks",
                      style: subTitleWithGreyFont.copyWith(fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 12,
                        color: AppColors.fmGrey100,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: subTitleWithGreyFont.copyWith(fontSize: 11),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.schedule,
                        size: 14,
                        color: AppColors.fmGrey100,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: subTitleWithGreyFont.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 3,
                    ),
                    child: Text(date, style: const TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 90,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      status,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...tasks.asMap().entries.map((entry) {
            final int i = entry.key;
            final task = entry.value;

            final bool shouldHide = !_showMoreTasks[taskIndex] && i >= 2;

            if (shouldHide) return const SizedBox.shrink();

            return Material(
              color: Colors.transparent,
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                visualDensity: VisualDensity.compact,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.fmBlue950,
                title: Text(task['label']),
                value: task['checked'],
                onChanged: (bool? newValue) {
                  setState(() {
                    taskList[taskIndex]['tasks'][i]['checked'] = newValue!;
                  });
                },
              ),
            );
          }),
          if (tasks.length > 2)
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showMoreTasks[taskIndex] = !_showMoreTasks[taskIndex];
                  });
                },
                child: Text(
                  _showMoreTasks[taskIndex] ? '- Show Less' : '+ More',
                  style: const TextStyle(
                    color: AppColors.fmBlue950,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: FMButton(
              onPressed: () {
                Navigator.of(context).push(
                  CustomRoute<MaterialPageRoute>(
                    builder: (_) => TaskDetailPage(),
                  ),
                );
              },
              label: 'View My Tasks',
              bgColor: AppColors.fmBlue950,
              labelStyle: TextStyle(color: AppColors.backgroundPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
