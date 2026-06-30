// ignore_for_file: file_names

import 'package:facility_management/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static void show(
    BuildContext context, {
    String title = '',
    required Widget content,
  }) {
    showModalBottomSheet(
      backgroundColor: AppColors.backgroundPrimary,

      context: context,
      builder: (BuildContext context) {
        return Card(
          color: AppColors.backgroundPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(child: content),
          ),
        );
      },
    );
  }
}
