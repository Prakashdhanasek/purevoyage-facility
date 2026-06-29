// ignore_for_file: always_specify_types, file_names

import 'package:flutter/material.dart';

class PopupMenuHelperEditAndDelete {
  static PopupMenuItem<String> buildMenuItem({
    required String value,
    required String text,
    required String iconPath,
    required Color iconColor,
  }) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: SizedBox(height: 18, width: 22, child: Image.asset(iconPath)),
            color: iconColor,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: iconColor,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
