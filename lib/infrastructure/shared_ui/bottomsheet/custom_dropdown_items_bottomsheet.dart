import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrix_campus/infrastructure/shared_ui/button/custom_button.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/theme/app_text_styles.dart';
import 'package:matrix_campus/infrastructure/utils/constants/string_constants.dart';

class BottomSheetItemModel {
  final String title;
  final String? description;
  final Widget? leading;

  const BottomSheetItemModel({
    required this.title,
    this.description,
    this.leading,
  });
}

class CustomDropdownItemsBottomsheet<T> extends StatelessWidget {
  final String? label;
  final Function(BottomSheetItemModel selectedItem)? onSelectItem;
  final double? height;
  final List<BottomSheetItemModel> items;

  const CustomDropdownItemsBottomsheet({
    required this.items,
    this.label,
    this.onSelectItem,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        border: Border(top: BorderSide(color: AppColors.text01)),
      ),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.h, 20.h, 20.h, 0),
          child: Column(
            children: [
              if (label != null) ...[
                Text(
                  label!,
                  style: AppTextStyles.body3Medium14(color: AppColors.text01),
                ),
                24.verticalSpace,
              ],

              Expanded(
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Align(
                        alignment: Alignment.center,
                        child: Text(
                          item.title,
                          style: AppTextStyles.body3Regular14(
                            color: AppColors.text01,
                          ),
                        ),
                      ),
                      subtitle:
                          item.description != null
                              ? Text(
                                item.description!,
                                style: AppTextStyles.body3Regular14(
                                  color: AppColors.text01,
                                ),
                              )
                              : null,
                      leading: item.leading,
                      selectedColor: AppColors.text02,
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        onSelectItem?.call(item);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 0.4,
                      height: 0,
                      color: AppColors.text03,
                    );
                  },
                  itemCount: items.length,
                ),
              ),

              24.verticalSpace,
              CustomButton(
                width: 108.w,
                wantBorder: false,
                disableElevation: true,
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  StringConstants.done,
                  style: AppTextStyles.body3Bold14(color: AppColors.text06),
                ),
              ),
              48.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
