// ignore_for_file: file_names

import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/app/theme/app_text_styles.dart';
import 'package:facility_management/core/constants/assets_paths.dart';
import 'package:facility_management/widgets/fm_app_bar.dart';
import 'package:facility_management/widgets/fm_toggle_button.dart';
import 'package:facility_management/widgets/fm_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/providers/global_provider.dart';

class TaskSupervisorPage extends StatefulWidget {
  const TaskSupervisorPage({super.key});

  @override
  State<TaskSupervisorPage> createState() => _TaskSupervisorPageState();
}

class _TaskSupervisorPageState extends State<TaskSupervisorPage> {
  int _selectedTabIndex = 1; // Default to 'Resolved' tab
  final List<TextEditingController> _commentControllers = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _commentControllers.addAll(
      List.generate(
        taskList.length,
        (index) =>
            TextEditingController(text: taskList[index]['comment'] ?? ''),
      ),
    );
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    for (var controller in _commentControllers) {
      controller.dispose();
    }
    _searchController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _tabs = <Map<String, dynamic>>[
    {'option': 'Active Alerts'},
    {'option': 'Resolved'},
  ];

  final List<Map<String, dynamic>> taskList = [
    {
      'title': 'Deck 5 - Port Side',
      'date': '17/08/2025',
      'status': 'Resolved',
      'statusColor': Colors.green,
      'location': 'Public Area',
      'time': '14:30',
      'comment':
          'Thank you for pointing that out. I\'ve noted the low supply levels and will ensure they\'re restocked promptly. I\'ll also monitor inventory more closely to avoid future shortages.',
    },
    {
      'title': 'Cabin D-247',
      'date': '16/08/2025',
      'status': 'Resolved',
      'statusColor': Colors.green,
      'location': 'Deck 6',
      'time': '10:15',
      'comment': 'All surfaces cleaned and vacuumed as per schedule.',
    },
    {
      'title': 'Engine Room C-309',
      'date': '18/08/2025',
      'status': 'Overdue',
      'statusColor': Colors.red,
      'location': 'Deck 1',
      'time': '09:00',
      'comment': 'Low supplies reported: soap and paper need restocking.',
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    if (_selectedTabIndex == -1) return [];
    final String selectedStatus =
        _tabs[_selectedTabIndex]['option'] == 'Active Alerts'
            ? 'Overdue'
            : 'Resolved';
    return taskList.where((task) {
      final matchesTab = task['status'] == selectedStatus;
      final matchesSearch =
          _searchQuery.isEmpty ||
          task['title'].toLowerCase().contains(_searchQuery) ||
          task['location'].toLowerCase().contains(_searchQuery);
      return matchesTab && matchesSearch;
    }).toList();
  }

  int getTaskCount(String tabOption) {
    final String status = tabOption == 'Active Alerts' ? 'Overdue' : 'Resolved';
    return taskList.where((task) => task['status'] == status).length;
  }

  void resolveTask(int taskIndex) {
    setState(() {
      taskList[taskIndex]['status'] = 'Resolved';
      taskList[taskIndex]['statusColor'] = Colors.green;
    });
  }

  void removeTask(int taskIndex) {
    setState(() {
      taskList.removeAt(taskIndex);
      _commentControllers.removeAt(taskIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: const FMAppBar(),
      body: Container(
        decoration: const BoxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              ModernSearchBar(
                controller: _searchController,
                hintText: 'Search Rooms',
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
              ),
              const SizedBox(height: 10),
              FMToggleButton(
                selectedIndex: _selectedTabIndex,
                onChangeSelected: (int index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
                optionList:
                    _tabs
                        .asMap()
                        .entries
                        .map(
                          (entry) => {
                            'option': entry.value['option'],
                            'count': getTaskCount(entry.value['option']),
                          },
                        )
                        .toList(),
                selectedColor: AppColors.fmBlue950,
              ),
              const SizedBox(height: 10),
              if (filteredTasks.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    _selectedTabIndex == -1
                        ? 'Select a tab to view tasks.'
                        : 'No tasks found for this category.',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ...filteredTasks.asMap().entries.map((entry) {
                final task = entry.value;
                final taskIndex = taskList.indexOf(task);
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: _buildTaskCard(
                    title: task['title'],
                    date: task['date'],
                    status: task['status'],
                    statusColor: task['statusColor'],
                    location: task['location'],
                    time: task['time'],
                    taskIndex: taskIndex,
                  ),
                );
              }),
            ],
          ),
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
    required String time,
    required int taskIndex,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
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
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 12,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        size: 12,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    date,
                    style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.4),
                        width: 0.6,
                      ),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 10,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey[200]),
          ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 0),
            title: const Text(
              'Supervisor Comment',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            children: [
              TextField(
                controller: _commentControllers[taskIndex],
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    taskList[taskIndex]['comment'] = value;
                  });
                },
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'Write your notes...',
                  filled: true,
                  fillColor: Colors.grey[50],
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
          if (status == 'Overdue')
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => resolveTask(taskIndex),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.fmBlue700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Resolve Alert',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// New Modern Search Bar Widget
class ModernSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const ModernSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
  });

  @override
  State<ModernSearchBar> createState() => _ModernSearchBarState();
}

class _ModernSearchBarState extends State<ModernSearchBar> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: AppColors.backgroundPrimary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (_isFocused)
              BoxShadow(
                color: AppColors.fmBlue950.withValues(alpha:0.2),
                blurRadius: 8,
                spreadRadius: 1,
              ),
          ],
          border: Border.all(
            color: _isFocused ? AppColors.fmBlue950 : Colors.grey[300]!,
            width: _isFocused ? 1.5 : 1,
          ),
        ),
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          style: titleH3.copyWith(fontSize: 15),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: titleH3.copyWith(fontSize: 15),
            prefixIcon: Icon(
              Icons.search,
              color: _isFocused ? AppColors.fmBlue950 : Colors.grey[500],
              size: 20,
            ),
            suffixIcon:
                widget.controller.text.isNotEmpty
                    ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.grey[500],
                        size: 20,
                      ),
                      onPressed: () {
                        widget.controller.clear();
                        widget.onChanged?.call('');
                      },
                    )
                    : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ),
    );
  }
}
