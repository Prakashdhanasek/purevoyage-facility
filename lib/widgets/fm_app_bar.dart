// ignore_for_file: file_names

import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/app/theme/app_text_styles.dart';
import 'package:facility_management/core/constants/assets_paths.dart';
import 'package:facility_management/data/providers/global_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/// A unified AppBar widget used across ALL screens in the app.
///
/// Two modes:
///  • **Logo mode** (default when [title] is null): Shows the pureVoyage logo
///    in the centre, a hamburger menu on the left, and a notification bell
///    with red-dot badge on the right.
///  • **Title mode** (when [title] is provided): Shows a solid blue bar with a
///    back-arrow on the left, the page title, and optional [actions] on the right.
class FMAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Page title. When null the widget renders in logo / home mode.
  final String? title;

  /// Called when the leading icon is tapped.
  ///   • Logo mode  → hamburger menu tap
  ///   • Title mode → back-arrow tap (falls back to smart navigation if null)
  final VoidCallback? onLeadingTap;

  /// Extra action widgets shown on the right (Title mode only).
  final List<Widget>? actions;

  /// Extra widget rendered along the bottom edge of the AppBar.
  final PreferredSizeWidget? bottom;

  const FMAppBar({
    super.key,
    this.title,
    this.onLeadingTap,
    this.actions,
    this.bottom,
  });

  // ─── Layout ──────────────────────────────────────────────────────────────

  bool get _isLogoMode => title == null;

  @override
  Size get preferredSize => Size.fromHeight(
        _isLogoMode
            ? kToolbarHeight + 16 + (bottom?.preferredSize.height ?? 1.5)
            : kToolbarHeight + (bottom?.preferredSize.height ?? 1.0),
      );

  // ─── Build ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return _isLogoMode ? _buildLogoAppBar(context) : _buildTitleAppBar(context);
  }

  // ── Logo / Home mode ─────────────────────────────────────────────────────

  Widget _buildLogoAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      toolbarHeight: kToolbarHeight + 16,
      titleSpacing: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black87, size: 28),
        onPressed: onLeadingTap ?? () {},
      ),
      title: Image.asset(
        AssetsPathConstants.fmLogoPath,
        fit: BoxFit.contain,
        width: 120,
        height: 120,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: InkWell(
              onTap: actions != null ? null : () {},
              borderRadius: BorderRadius.circular(20),
              // If caller supplied actions list, use the first widget as the
              // notification trigger; otherwise render the default bell icon.
              child:
                  (actions != null && actions!.isNotEmpty)
                      ? actions!.first
                      : _defaultNotificationBell(),
            ),
          ),
        ),
      ],
      bottom: bottom ??
          PreferredSize(
            preferredSize: const Size.fromHeight(1.5),
            child: Container(
              color: const Color(0xFF2C3E94).withValues(alpha: 0.15),
              height: 1.5,
            ),
          ),
    );
  }

  Widget _defaultNotificationBell() {
    return Stack(
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
    );
  }

  // ── Titled / Sub-page mode ────────────────────────────────────────────────

  Widget _buildTitleAppBar(BuildContext context) {
    return AppBar(
      elevation: 4,
      backgroundColor: Colors.white,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: AppColors.fmBlue950,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      leading: IconButton(
        onPressed: onLeadingTap ?? _defaultBackAction(context),
        highlightColor: Colors.transparent,
        icon: const Icon(
          Icons.arrow_back_outlined,
          color: Colors.white,
          size: 24,
        ),
      ),
      leadingWidth: 70,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          title!,
          style: titleH4.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      titleSpacing: 0,
      actionsPadding: const EdgeInsets.only(right: 16),
      actions: actions ?? const [],
      bottom: bottom ??
          PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: AppColors.fmBlue950),
          ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// Smart back-navigation used when no [onLeadingTap] is provided in title mode.
  VoidCallback _defaultBackAction(BuildContext context) {
    return () {
      final globalProvider =
          Provider.of<GlobalProvider>(context, listen: false);
      if (globalProvider.selectedPageIndex == 0) {
        Navigator.pop(context);
      } else {
        final newIndex = globalProvider.selectedPageIndex - 1;
        globalProvider.changeIndex(newIndex);
        globalProvider.updateStaffPage(newIndex);
        globalProvider.updateSuperVisorPage(newIndex);
      }
    };
  }
}

// ─── Helper function kept for backward compatibility ──────────────────────────
// Screens that previously called the top-level `fmAppBar()` function can
// continue to do so; it now delegates to FMAppBar in logo mode.

/// [Deprecated] Use [FMAppBar] directly instead.
PreferredSizeWidget fmAppBar({
  required VoidCallback onClickMenu,
  required VoidCallback onClickProfile,
}) {
  return FMAppBar(
    onLeadingTap: onClickMenu,
    // Wrap the caller's notification callback in an InkWell so it fires.
    actions: [
      InkWell(
        onTap: onClickProfile,
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
  );
}

/// [Deprecated] Use [FMAppBar] directly instead.
PreferredSizeWidget commonAppBar({
  required String title,
  VoidCallback? onPressBack,
  required BuildContext context,
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
}) {
  return FMAppBar(
    title: title,
    onLeadingTap: onPressBack,
    actions: actions,
    bottom: bottom,
  );
}
