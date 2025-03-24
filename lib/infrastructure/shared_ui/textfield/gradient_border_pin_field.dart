import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/theme/app_text_styles.dart';
import 'package:pinput/pinput.dart';

class GradientBorderPinField extends StatefulWidget {
  const GradientBorderPinField({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GradientBorderPinInputState createState() => _GradientBorderPinInputState();
}

class _GradientBorderPinInputState extends State<GradientBorderPinField> {
  final int pinLength = 4;
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();

    // Create controllers and focus nodes
    for (int i = 0; i < pinLength; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }
  }

  final defaultPinTheme = PinTheme(
    width: 58.w,
    height: 36.h,
    margin: EdgeInsets.only(right: 10.w),
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    textStyle: AppTextStyles.body4Regular12(color: AppColors.text01),
    decoration: BoxDecoration(
      color: AppColors.extra08,
      border: Border.all(color: AppColors.extra07),
      borderRadius: BorderRadius.circular(24.r),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pinLength,
        (index) => Container(
          margin: EdgeInsets.only(right: 10.w),
          width: 58.w,
          height: 36.h,
          child: Focus(
            onFocusChange: (hasFocus) {
              // Rebuild when focus changes
              setState(() {});
            },
            child: Builder(
              builder: (context) {
                final isFocused = focusNodes[index].hasFocus;

                if (isFocused) {
                  // Gradient border for focused field
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      gradient: LinearGradient(
                        begin: Alignment(-1.0, -0.5),
                        end: Alignment(1.0, 0.8),
                        colors: [
                          AppColors.secondary02,
                          AppColors.secondary03,
                          AppColors.primary06,
                        ],
                        stops: [0.0, 0.65, 1.0],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.extra08,
                          borderRadius: BorderRadius.circular(22.r),
                        ),
                        child: TextFormField(
                          cursorColor: AppColors.text01,
                          controller: controllers[index],
                          focusNode: focusNodes[index],
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          style: AppTextStyles.body4Regular12(
                            color: AppColors.text01,
                          ),
                          decoration: InputDecoration(
                            hintStyle: AppTextStyles.body4Regular12(
                              color: AppColors.text03,
                            ),
                            counterText: "",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              // Auto jump to next field
                              if (index < pinLength - 1) {
                                focusNodes[index + 1].requestFocus();
                              } else {
                                // Close keyboard if last field is filled
                                FocusScope.of(context).unfocus();
                              }
                            } else {
                              // Auto jump to previous field
                              if (index > 0) {
                                focusNodes[index - 1].requestFocus();
                              } else {
                                // Close keyboard if last field is empty
                                FocusScope.of(context).unfocus();
                              }
                            }
                          },
                          // Added to allow only numeric input
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  // Default theme for non-focused fields
                  return Container(
                    decoration: defaultPinTheme.decoration,
                    child: TextField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      style: AppTextStyles.body4Regular12(
                        color: AppColors.text01,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: '-',
                        hintStyle: AppTextStyles.body4Regular12(
                          color: AppColors.text03,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          // Auto jump to next field
                          if (index < pinLength - 1) {
                            focusNodes[index + 1].requestFocus();
                          } else {
                            // Close keyboard if last field is filled
                            FocusScope.of(context).unfocus();
                          }
                        } else {
                          // Auto jump to previous field
                          if (index > 0) {
                            focusNodes[index - 1].requestFocus();
                          } else {
                            // Close keyboard if last field is empty
                            FocusScope.of(context).unfocus();
                          }
                        }
                      },
                      // Added to allow only numeric input
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}
