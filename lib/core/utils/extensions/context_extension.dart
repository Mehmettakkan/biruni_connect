import 'package:biruni_connect/core/constants/ui/ui_constants.dart';
import 'package:biruni_connect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  // Media Query Extensions
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  double get topPadding => mediaQuery.padding.top;
  double get bottomPadding => mediaQuery.padding.bottom;
  bool get isKeyboardOpen => mediaQuery.viewInsets.bottom > 0;
  Orientation get orientation => mediaQuery.orientation;

  // Responsive Height Extensions
  double get heightPercent10 => height * 0.1;
  double get heightPercent20 => height * 0.2;
  double get heightPercent30 => height * 0.3;
  double get heightPercent40 => height * 0.4;
  double get heightPercent50 => height * 0.5;
  double get heightPercent60 => height * 0.6;
  double get heightPercent70 => height * 0.7;
  double get heightPercent80 => height * 0.8;
  double get heightPercent90 => height * 0.9;

  // Responsive Width Extensions
  double get widthPercent10 => width * 0.1;
  double get widthPercent20 => width * 0.2;
  double get widthPercent30 => width * 0.3;
  double get widthPercent40 => width * 0.4;
  double get widthPercent50 => width * 0.5;
  double get widthPercent60 => width * 0.6;
  double get widthPercent70 => width * 0.7;
  double get widthPercent80 => width * 0.8;
  double get widthPercent90 => width * 0.9;

  // Theme Extensions
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
  bool get isDark => theme.brightness == Brightness.dark;

  // Padding Extensions - All
  EdgeInsets get paddingXS => const EdgeInsets.all(UIConstants.paddingXS);
  EdgeInsets get paddingS => const EdgeInsets.all(UIConstants.paddingS);
  EdgeInsets get paddingM => const EdgeInsets.all(UIConstants.paddingM);
  EdgeInsets get paddingL => const EdgeInsets.all(UIConstants.paddingL);
  EdgeInsets get paddingXL => const EdgeInsets.all(UIConstants.paddingXL);

  // Padding Extensions - Horizontal
  EdgeInsets get paddingHorizontalXS =>
      const EdgeInsets.symmetric(horizontal: UIConstants.paddingXS);
  EdgeInsets get paddingHorizontalS =>
      const EdgeInsets.symmetric(horizontal: UIConstants.paddingS);
  EdgeInsets get paddingHorizontalM =>
      const EdgeInsets.symmetric(horizontal: UIConstants.paddingM);
  EdgeInsets get paddingHorizontalL =>
      const EdgeInsets.symmetric(horizontal: UIConstants.paddingL);
  EdgeInsets get paddingHorizontalXL =>
      const EdgeInsets.symmetric(horizontal: UIConstants.paddingXL);

  // Padding Extensions - Vertical
  EdgeInsets get paddingVerticalXS =>
      const EdgeInsets.symmetric(vertical: UIConstants.paddingXS);
  EdgeInsets get paddingVerticalS =>
      const EdgeInsets.symmetric(vertical: UIConstants.paddingS);
  EdgeInsets get paddingVerticalM =>
      const EdgeInsets.symmetric(vertical: UIConstants.paddingM);
  EdgeInsets get paddingVerticalL =>
      const EdgeInsets.symmetric(vertical: UIConstants.paddingL);
  EdgeInsets get paddingVerticalXL =>
      const EdgeInsets.symmetric(vertical: UIConstants.paddingXL);

  // Padding Extensions - Custom
  EdgeInsets get paddingSafeArea => EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
      );
  EdgeInsets get paddingKeyboard => EdgeInsets.only(
        bottom: mediaQuery.viewInsets.bottom,
      );

  // Border Radius Extensions
  BorderRadius get radiusXS => BorderRadius.circular(UIConstants.radiusXS);
  BorderRadius get radiusS => BorderRadius.circular(UIConstants.radiusS);
  BorderRadius get radiusM => BorderRadius.circular(UIConstants.radiusM);
  BorderRadius get radiusL => BorderRadius.circular(UIConstants.radiusL);
  BorderRadius get radiusXL => BorderRadius.circular(UIConstants.radiusXL);
  BorderRadius get radiusCircular => BorderRadius.circular(999);

  // Spacing Extensions - Vertical
  Widget get spaceXS => const SizedBox(height: UIConstants.spacingXS);
  Widget get spaceS => const SizedBox(height: UIConstants.spacingS);
  Widget get spaceM => const SizedBox(height: UIConstants.spacingM);
  Widget get spaceL => const SizedBox(height: UIConstants.spacingL);
  Widget get spaceXL => const SizedBox(height: UIConstants.spacingXL);

  // Spacing Extensions - Horizontal
  Widget get horizontalSpaceXS => const SizedBox(width: UIConstants.spacingXS);
  Widget get horizontalSpaceS => const SizedBox(width: UIConstants.spacingS);
  Widget get horizontalSpaceM => const SizedBox(width: UIConstants.spacingM);
  Widget get horizontalSpaceL => const SizedBox(width: UIConstants.spacingL);
  Widget get horizontalSpaceXL => const SizedBox(width: UIConstants.spacingXL);

  // Device Type Extensions
  bool get isPhone => width < 600;
  bool get isTablet => width >= 600 && width < 1200;
  bool get isDesktop => width >= 1200;

  // Screen Size Extensions
  bool get isSmallScreen => height < 700;
  bool get isMediumScreen => height >= 700 && height < 900;
  bool get isLargeScreen => height >= 900;

  // Navigation Extensions
  bool get canPop => Navigator.of(this).canPop();
  void get pop => Navigator.of(this).pop();

  // Overlay Extensions
  OverlayState? get overlay => Overlay.of(this);

  // Focus Extensions
  void get unfocus => FocusScope.of(this).unfocus();

  // Snackbar Extensions
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : colors.primary,
        behavior: SnackBarBehavior.floating,
        margin: paddingM,
        shape: RoundedRectangleBorder(borderRadius: radiusM),
      ),
    );
  }

  // Dialog Extensions
  Future<T?> showAppDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: context.radiusL),
        child: child,
      ),
    );
  }

  // Bottom Sheet Extensions
  Future<T?> showAppBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isDismissible: isDismissible,
      isScrollControlled: true,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(UIConstants.radiusL)),
      ),
      builder: (context) => child,
    );
  }
}
