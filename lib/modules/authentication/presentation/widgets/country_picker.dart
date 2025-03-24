import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';

class CountryPicker extends StatelessWidget {
  const CountryPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
        color: AppColors.extra08,
        border: Border.all(color: AppColors.extra07, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(24.r)),
      ),
      child: Row(
        children: [
          CountryCodePicker(
            initialSelection: 'IN',
            showCountryOnly: false,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            hideMainText: true,
            flagWidth: 24.w,
            boxDecoration: BoxDecoration(
              color: AppColors.extra08,
              border: Border.all(color: AppColors.extra07),
              borderRadius: BorderRadius.all(Radius.circular(24.r)),
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.text01.withOpacity(0.4),
          ),
          8.horizontalSpace,
        ],
      ),
    );
  }
}
