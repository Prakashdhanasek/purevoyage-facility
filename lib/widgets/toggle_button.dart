import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChangeSelected;
  final Color selectedColor;
  final List<Map<String, dynamic>> optionList;

  const ToggleButton({
    super.key,
    required this.onChangeSelected,
    required this.selectedIndex,
    required this.optionList,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.backgroundQuaternary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(
            optionList.length,
            (int index) => GestureDetector(
              onTap: () {
                onChangeSelected(index);
              },
              child: Container(
                constraints: BoxConstraints(minWidth: 80, maxWidth: 120),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color:
                      selectedIndex == index
                          ? AppColors.backgroundPrimary
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow:
                      selectedIndex == index
                          ? <BoxShadow>[
                            BoxShadow(
                              color: AppColors.commonFontColorPrimary.withAlpha(
                                15,
                              ),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                            BoxShadow(
                              color: AppColors.commonFontColorPrimary.withAlpha(
                                5,
                              ),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ]
                          : <BoxShadow>[],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        optionList[index]['option'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            selectedIndex == index
                                ? captionsMetadata.copyWith(
                                  fontSize: 14,
                                  color: selectedColor,
                                  fontWeight: FontWeight.bold,
                                )
                                : smallTextButtons.copyWith(
                                  color: AppColors.fmGrey200,
                                ),
                      ),
                    ),
                    if (optionList[index]['count'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          optionList[index]['count'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              selectedIndex == index
                                  ? captionsMetadata.copyWith(
                                    fontSize: 14,
                                    color: selectedColor,
                                    fontWeight: FontWeight.bold,
                                  )
                                  : smallTextButtons.copyWith(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
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
