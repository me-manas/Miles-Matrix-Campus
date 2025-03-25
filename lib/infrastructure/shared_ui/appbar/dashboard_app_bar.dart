import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/utils/constants/assets/assets_path.dart';
import 'package:matrix_campus/infrastructure/utils/helpers/image_loader.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hideLeading;
  final bool hideActions;
  final Color? backgroundColor;
  const DashboardAppBar({
    this.hideLeading = false,
    this.hideActions = false,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.extra05,
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 36.w),
        leading:
            hideLeading
                ? const SizedBox.shrink()
                : GestureDetector(
                  onTap: () {},
                  child: ImageLoader.assetSvg(
                    AssetsPath.svg.dashboardMenu,
                    fit: BoxFit.scaleDown,
                  ),
                ),
        title: ImageLoader.assetSvg(AssetsPath.svg.matrixLogo),
        actions:
            hideActions
                ? null
                : [
                  GestureDetector(
                    onTap: () {},
                    child: ImageLoader.assetSvg(
                      AssetsPath.svg.dashboardNotification,
                    ),
                  ),
                ],
      ),
    );
  }

  @override
  // 56 is the height for appbar as per material design
  Size get preferredSize => Size.fromHeight(56);
}
