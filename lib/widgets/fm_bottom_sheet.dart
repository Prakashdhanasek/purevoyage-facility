import 'package:facility_management/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

void customShowModalBottomSheet({
  required BuildContext context,
  required Widget inputWidget,
  Widget? errorDialogue,
  AnimationController? controller,
  BoxConstraints? heightConstraint,
  bool dismissable = true,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.backgroundPrimary,
    transitionAnimationController: controller,
    isDismissible: dismissable,
    enableDrag: dismissable,
    constraints:
        heightConstraint ??
        BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
    ),
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Draggable handle indicator
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 11),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundQuaternary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    height: 4,
                    width: 64,
                  ),
                ),
              ),
              // Main content with proper keyboard handling
              Flexible(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: inputWidget,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
