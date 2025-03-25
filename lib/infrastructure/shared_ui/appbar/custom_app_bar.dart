import 'package:flutter/material.dart';
import 'package:matrix_campus/infrastructure/utils/constants/assets/assets_path.dart';
import 'package:matrix_campus/infrastructure/utils/helpers/image_loader.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? action;
  final bool backEnabled;
  final VoidCallback? onBack;
  final String? title;
  final Color? backgroundColor;
  const CustomAppBar({
    this.backEnabled = true,
    this.action,
    this.title,
    this.onBack,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading:
          backEnabled
              ? GestureDetector(
                onTap:
                    onBack ??
                    () {
                      Navigator.pop(context);
                    },
                child: Transform.scale(
                  scale: 0.6,
                  child: ImageLoader.assetSvg(AssetsPath.svg.back),
                ),
              )
              : const SizedBox.shrink(),
      actions: action,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
