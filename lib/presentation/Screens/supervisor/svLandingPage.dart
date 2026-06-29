// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import 'home/home_screen.dart';

class Svlandingpage extends StatefulWidget {
  const Svlandingpage({super.key});

  @override
  State<Svlandingpage> createState() => _SvlandingpageState();
}

class _SvlandingpageState extends State<Svlandingpage> {
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      body: HomeSupervisorPage(),
    );
  }
}
