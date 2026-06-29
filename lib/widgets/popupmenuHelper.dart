// ignore_for_file: file_names

import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/app/theme/app_text_styles.dart';
import 'package:facility_management/core/constants/assets_paths.dart';
import 'package:flutter/material.dart';

class PopupMenuHelper {
  static PopupMenuItem<String> buildMenuItem({
    required String text,
    String? iconPath,
    Color iconColor = AppColors.fmBlue800,
    Color textColor = AppColors.fmBlue800,
    FontWeight fontWeight = FontWeight.w500,
    double? height,
    double? width,
  }) {
    return PopupMenuItem<String>(
      value: text,
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon:
                (text == 'Filter')
                    ? SizedBox(
                      height: height ?? 20,
                      width: width ?? 20,
                      child: Image.asset(
                        AssetsPathConstants.filterIconImagePath,
                      ),
                    )
                    : iconPath != null
                    ? Image.asset(
                      iconPath,
                      height: height ?? 20,
                      width: width ?? 20,
                    )
                    : const Icon(Icons.add_circle_outline_outlined),
            color: iconColor,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: appBarTitle.copyWith(
              color: textColor,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
