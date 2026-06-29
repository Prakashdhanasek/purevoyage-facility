import 'dart:async';
import 'package:facility_management/core/constants/assets_paths.dart';
import 'package:facility_management/presentation/Screens/subPages/notificationDrawer.dart';
import 'package:facility_management/widgets/fm_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/app/theme/app_text_styles.dart';
import 'package:facility_management/widgets/fm_button.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({super.key});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  bool taskStarted = false;
  bool isPaused = false;
  late Timer _timer;
  Duration _elapsed = Duration.zero;

  Map<String, dynamic> taskData = {
    'title': 'Cabin B-156',
    'date': '17/08/2025',
    'status': 'Active',
    'statusColor': Colors.green.shade100,
    'statusTextColor': Colors.green,
    'location': 'Deck 8',
    'duration': '1 Hour',
    'requiredTasks': 10,
    'tasks': [
      {
        'label': 'Clean and disinfect toilet',
        'checked': false,
        'priority': 'High',
      },
      {
        'label': 'Refill soap dispensers',
        'checked': false,
        'priority': 'Medium',
      },
      {'label': 'Empty trash bins', 'checked': true, 'priority': 'Low'},
      {
        'label': 'Mop floors with disinfectant',
        'checked': false,
        'priority': 'High',
      },
    ],
  };

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isPaused) {
        setState(() {
          _elapsed += const Duration(seconds: 1);
        });
      }
    });
  }

  String _formatTime(Duration d) {
    return "Started :${d.inHours.toString().padLeft(2, '0')}:${(d.inMinutes % 60).toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  void _toggleTask() {
    setState(() {
      taskStarted = true;
      isPaused = false;
      _elapsed = Duration.zero;
    });
    _startTimer();
  }

  void _togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final tasks = taskData['tasks'] as List<Map<String, dynamic>>;
    final int totalTasks = tasks.length;
    final int completedTasks = tasks.where((t) => t['checked']).length;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.backgroundSecondary,
      appBar: FMAppBar(
        onLeadingTap: () => Navigator.pop(context),
        actions: [
          taskStarted
              ? Container(
                  width: 150,
                  height: 30,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C3E94).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF2C3E94).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        color: Color(0xFF2C3E94),
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        textAlign: TextAlign.center,
                        _formatTime(_elapsed),
                        style: const TextStyle(
                          color: Color(0xFF2C3E94),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )
              : InkWell(
                  onTap: () =>
                      _scaffoldKey.currentState?.openEndDrawer(),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTaskInfo(completedTasks, totalTasks),
            const SizedBox(height: 20),
            _buildChecklist(tasks),
            const SizedBox(height: 15),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskInfo(int completed, int total) {
    final remaining = total - completed;
    final progress = total > 0 ? completed / total : 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLeftDetails(),
              Column(
                children: [
                  Text(taskData['date'], style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: taskData['statusColor'],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      taskData['status'],
                      style: TextStyle(
                        color: taskData['statusTextColor'],
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text("Progress", style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.fmGreen,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$completed/$total Tasks',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                "$completed/$total Required Tasks",
                style: const TextStyle(fontSize: 12, color: Colors.green),
              ),
              const Spacer(),
              Text(
                "($remaining Required Remaining)",
                style: const TextStyle(fontSize: 12, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeftDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          taskData['title'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          "${taskData['requiredTasks']} Required Tasks",
          style: subTitleWithGreyFont.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.location_pin, size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              taskData['location'],
              style: subTitleWithGreyFont.copyWith(fontSize: 11),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.schedule, size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              taskData['duration'],
              style: subTitleWithGreyFont.copyWith(fontSize: 11),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChecklist(List<Map<String, dynamic>> tasks) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cleaning Checklist",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "Complete all Required Tasks",
            style: subTitleWithGreyFont.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 12),
          ...tasks.asMap().entries.map((entry) {
            final task = entry.value;
            final int i = entry.key;
            final String priority = task['priority'];
            final Color priorityColor = _getPriorityColor(priority);
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.backgroundPrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: task['checked'],
                    activeColor: AppColors.fmBlue950,
                    onChanged: (val) {
                      setState(() => taskData['tasks'][i]['checked'] = val);
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task['label']),
                        Row(
                          children: [
                            Text(
                              priority,
                              style: TextStyle(
                                color: priorityColor,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              "• Pending",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _showUploadTaskPictureDialog(context),
                    child: Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.fmBlue900),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Upload",
                        style: TextStyle(
                          color: AppColors.fmBlue950,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (!taskStarted) {
      return FMButton(
        height: 40,
        onPressed: _toggleTask,
        label: 'Finish Task',
        bgColor: AppColors.fmBlue950,
        labelStyle: const TextStyle(color: Colors.white),
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: FMButton(
              height: 40,
              onPressed: _togglePause,
              label: isPaused ? 'Continue' : 'Pause',
              icon: isPaused ? Icons.play_arrow : Icons.pause,
              bgColor: isPaused ? Colors.blue : AppColors.fmOrange,
              labelStyle: const TextStyle(color: Colors.white),
              borderColor: Colors.transparent,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: FMButton(
              height: 40,
              onPressed: () {},
              label: 'Complete',
              bgColor: AppColors.fmGreen,
              labelStyle: const TextStyle(color: Colors.white),
              borderColor: AppColors.fmGreen,
              icon: Icons.check_circle_outline,
            ),
          ),
        ],
      );
    }
  }

  void _showUploadTaskPictureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => Dialog(
            backgroundColor: AppColors.backgroundPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 32),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Upload Tasks Picture',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Image.asset(
                    AssetsPathConstants.uploadImagePath,
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),
                  FMButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icons.camera_alt_outlined,
                    iconColor: AppColors.fmBlue950,
                    label: 'Take the Picture',
                    bgColor: AppColors.backgroundPrimary,
                    labelStyle: TextStyle(color: AppColors.fmBlue950),
                  ),
                  const SizedBox(height: 12),
                  FMButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icons.file_upload_outlined,
                    label: 'Upload the Picture',
                    bgColor: AppColors.fmBlue950,
                    labelStyle: const TextStyle(
                      color: AppColors.backgroundPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
