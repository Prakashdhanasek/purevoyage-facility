import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepLabels;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // Back button at step > 0
              if (currentStep > 0)
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: AppColors.fmBlue800,
                  ),
                  onPressed: () {
                    // This will be implemented via a callback
                  },
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              // Progress text
              Text(
                'Step ${currentStep + 1} of $totalSteps',
                style: TextStyle(color: AppColors.fmBlue800),
              ),
              Spacer(),
              // Step progress bar
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    // Background track
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    // Progress fill
                    FractionallySizedBox(
                      widthFactor: (currentStep + 1) / totalSteps,
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.fmBlue500, AppColors.fmBlue800],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              // Close button (X)
              InkWell(
                onTap: () {
                  // This will be implemented via a callback
                },
                child: Icon(Icons.close, size: 20, color: Colors.grey),
              ),
            ],
          ),
        ),

        // Step Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              stepLabels[currentStep],
              style: titleH4.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.commonFontColorPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
