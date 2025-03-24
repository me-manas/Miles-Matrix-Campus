import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool? isDisabled;
  final Widget? child;
  final Color? buttonColor;
  final Color? hoverColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? width;
  final bool? wantBorder;
  final bool? disableElevation;
  final Color? borderColor;
  final Color? disabledColor;
  final double? height;
  final double? borderRadius;
  final InteractiveInkFeatureFactory? splashFactory;
  final bool showGlowEffect;
  final Color? glowColor;
  final double? glowSpreadRadius;
  final double? glowBlurRadius;

  /// If [onPressed] is null the button will be treated as disabled and it's color
  /// will be greyed out
  const CustomButton({
    super.key,
    this.onPressed,
    this.isDisabled,
    this.child,
    this.buttonColor,
    this.hoverColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.width,
    this.wantBorder,
    this.borderColor,
    this.disableElevation,
    this.disabledColor,
    this.height,
    this.borderRadius,
    this.splashFactory,
    this.showGlowEffect = false,
    this.glowColor,
    this.glowSpreadRadius,
    this.glowBlurRadius,
  });

  @override
  Widget build(BuildContext context) {
    bool enabled = _checkEnabled();
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 4),
        boxShadow:
            showGlowEffect
                ? [
                  BoxShadow(
                    color: glowColor ?? AppColors.text01.withOpacity(0.5),
                    spreadRadius: glowSpreadRadius ?? 1,
                    blurRadius: glowBlurRadius ?? 8,
                    offset: const Offset(0, 0),
                  ),
                ]
                : null,
      ),
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: disableElevation == true ? 0 : null,
          splashFactory: splashFactory ?? NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 24.r),
            side:
                wantBorder == true
                    ? BorderSide(
                      width: 1,
                      color: borderColor ?? AppColors.primary06,
                    )
                    : BorderSide.none,
          ),
          backgroundColor:
              enabled ? (buttonColor ?? AppColors.primary06) : AppColors.text02,
          disabledForegroundColor: AppColors.text03,
          disabledBackgroundColor: disabledColor ?? AppColors.text02,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? 14,
            horizontal: horizontalPadding ?? 0,
          ),
        ),
        child: child,
      ),
    );
  }

  bool _checkEnabled() {
    bool enabled = (!(isDisabled ?? false));
    return enabled;
  }
}
