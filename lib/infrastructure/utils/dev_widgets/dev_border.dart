import 'package:flutter/material.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';

class DevBorder extends StatelessWidget {
  final Widget child;
  final Color? borderColor;
  const DevBorder({required this.child, this.borderColor, super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? AppColors.text01),
      ),
      child: child,
    );
  }
}
