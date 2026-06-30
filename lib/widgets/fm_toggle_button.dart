import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class FMToggleButton extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChangeSelected;
  final Color selectedColor;
  final List<Map<String, dynamic>> optionList;

  const FMToggleButton({
    super.key,
    required this.onChangeSelected,
    required this.selectedIndex,
    required this.optionList,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.backgroundTertiary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(
          optionList.length,
          (int index) => GestureDetector(
            onTap: () {
              onChangeSelected(index);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 2),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color:
                      selectedIndex == index
                          ? selectedColor
                          : AppColors.backgroundPrimary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow:
                      selectedIndex == index
                          ? [
                            BoxShadow(
                              color: AppColors.commonFontColorPrimary
                                  .withValues(alpha: 0.06),
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: const Offset(0, 1),
                            ),
                            BoxShadow(
                              color: AppColors.commonFontColorPrimary
                                  .withValues(alpha: 0.01),
                              blurRadius: 3,
                              spreadRadius: 0,
                              offset: const Offset(0, 1),
                            ),
                          ]
                          : [],
                ),
                child: Row(
                  children: [
                    Text(
                      optionList[index]['option'],
                      style:
                          selectedIndex == index
                              ? captionsMetadata.copyWith(
                                color:
                                    AppColors
                                        .backgroundPrimary, // White text for selected
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              )
                              : smallTextButtons.copyWith(
                                color:
                                    selectedColor, // Blue text for unselected
                                fontSize: 12,
                              ),
                    ),
                    if (optionList[index]['count'] != null)
                      Row(
                        children: [
                          const SizedBox(width: 6),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color:
                                  selectedIndex == index
                                      ? AppColors.backgroundPrimary
                                      : selectedColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                optionList[index]['count'].toString(),
                                style: smallCaptions.copyWith(
                                  color:
                                      selectedIndex == index
                                          ? selectedColor
                                          : AppColors.backgroundPrimary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
