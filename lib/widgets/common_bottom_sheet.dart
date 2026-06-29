// ignore_for_file: must_be_immutable

import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/app/theme/app_text_styles.dart';
import 'package:facility_management/widgets/fm_button.dart';
import 'package:flutter/material.dart';

class CommonBottomSheet extends StatelessWidget {
  final Function() positiveOnPress;
  final Function() negativePress;
  Color? postiveBtnClr;
  String title;
  String? postiveTxt;
  String? negativeTxt;

  CommonBottomSheet({
    super.key,
    required this.positiveOnPress,
    required this.negativePress,
    required this.title,
    this.postiveBtnClr,
    this.postiveTxt,
    this.negativeTxt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: titleH4.copyWith(color: AppColors.fmBlue800)),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: FMButton(
                      bgColor: AppColors.backgroundPrimary,
                      label: negativeTxt ?? 'Cancel',
                      labelStyle: bodyText.copyWith(color: AppColors.fmBlue800),
                      onPressed: negativePress,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FMButton(
                      bgColor: postiveBtnClr ?? AppColors.fmBlue800,
                      borderColor: postiveBtnClr ?? AppColors.fmBlue800,
                      label: postiveTxt ?? 'Yes',
                      labelStyle: bodyText.copyWith(
                        color: AppColors.backgroundPrimary,
                      ),
                      onPressed: positiveOnPress,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
