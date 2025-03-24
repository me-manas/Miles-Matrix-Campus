import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/theme/app_text_styles.dart';

class CustomTextfieldWithLabel extends StatefulWidget {
  const CustomTextfieldWithLabel({
    this.textInputAction,
    this.textInputType,
    this.titleSuffix,
    this.isRequired = false,
    this.maxLength,
    this.currentLength,
    this.isElevated = true,
    this.showRequiredWithHint = false,
    this.hintText,
    this.errorText,
    this.suffixIcon,
    this.obscure,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.enabled,
    this.controller,
    this.initialValue,
    this.autocorrect,
    this.autoFocus,
    this.prefixIcon,
    this.onSaved,
    this.hintStyle,
    this.labelStyle,
    this.textAlignVertical,
    this.fillColor,
    this.maxLines = 1,
    this.minLines,
    this.labelText,
    this.showLabelText,
    this.labelFontSize,
    this.borderRadius,
    this.textStyle,
    this.borderWidth = 1,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    super.key,
  });

  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final Widget? titleSuffix;
  final bool isRequired;
  final int? maxLength;
  final int? currentLength;
  final bool isElevated;
  final String? hintText;
  final String? initialValue;
  final String? errorText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscure;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? enabled;
  final bool? autocorrect;
  final bool? autoFocus;
  final FormFieldSetter? onSaved;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final TextAlignVertical? textAlignVertical;
  final Widget? prefixIcon;
  final Color? fillColor;
  final int? maxLines;
  final int? minLines;
  final String? labelText;
  final bool? showLabelText;
  final double? labelFontSize;
  final double? borderRadius;
  final double borderWidth;
  final bool showRequiredWithHint;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;

  @override
  State<CustomTextfieldWithLabel> createState() =>
      _CustomTextfieldWithLabelState();
}

class _CustomTextfieldWithLabelState extends State<CustomTextfieldWithLabel> {
  Widget? customSuffixIcon;
  bool fieldIsNotEmpty = true;
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _isFocused = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    customSuffixIcon = widget.suffixIcon;
    fieldIsNotEmpty = widget.controller?.text.isNotEmpty ?? false;
    _focusNode.addListener(() {
      _isFocused.value = !_isFocused.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText?.isNotEmpty == true) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                Text(
                  widget.labelText!,
                  style: AppTextStyles.body4Regular12(color: AppColors.text01),
                ),
                if (widget.isRequired == true)
                  Text(
                    '*',
                    style: AppTextStyles.body4Regular12(
                      color: AppColors.extra04,
                    ),
                  ),
                if (widget.titleSuffix != null) ...[
                  const Spacer(),
                  widget.titleSuffix!,
                ],
              ],
            ),
          ),
          2.verticalSpace,
        ],
        ValueListenableBuilder<bool>(
          valueListenable: _isFocused,
          builder: (context, value, child) {
            return DecoratedBox(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 24.r,
                  ),
                ),
                gradient:
                    value
                        ? LinearGradient(
                          begin: Alignment(-1.0, -0.5),
                          end: Alignment(1.0, 0.8),
                          colors: [
                            AppColors.secondary02,
                            AppColors.secondary03,
                            AppColors.primary06,
                          ],
                          stops: [0.0, 0.65, 1.0],
                        )
                        : null,
              ),
              child: Container(
                margin: EdgeInsets.all(widget.borderWidth), // Border Thickness
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 24.r,
                  ),
                ),
                child: TextFormField(
                  style:
                      widget.textStyle ??
                      AppTextStyles.body3Regular14(color: AppColors.text01),
                  focusNode: _focusNode,
                  onTapOutside: (_) {
                    _focusNode.unfocus();
                  },
                  textAlign: widget.textAlign,
                  maxLines: widget.maxLines,
                  minLines: widget.minLines,
                  keyboardType: widget.textInputType,
                  textAlignVertical: widget.textAlignVertical,
                  textInputAction:
                      widget.textInputAction ?? TextInputAction.next,
                  controller: widget.controller,
                  enabled: widget.enabled,
                  inputFormatters: widget.inputFormatters,
                  autofocus: widget.autoFocus ?? false,
                  validator: widget.validator,
                  initialValue: widget.initialValue,
                  onChanged: widget.onChanged,
                  autocorrect: widget.autocorrect ?? true,
                  onSaved: widget.onSaved,
                  textCapitalization: widget.textCapitalization,
                  decoration: InputDecoration(
                    prefixIcon: widget.prefixIcon,
                    fillColor: widget.fillColor ?? AppColors.extra08,
                    filled: true,
                    hintText: widget.hintText,
                    errorStyle: AppTextStyles.body4Regular12(
                      color: AppColors.extra04,
                    ),

                    labelStyle:
                        widget.labelStyle ??
                        AppTextStyles.body3Regular14(color: AppColors.text01),
                    hintStyle:
                        widget.hintStyle ??
                        AppTextStyles.body3Regular14(color: AppColors.text03),
                    alignLabelWithHint: false,
                    border:
                        value
                            ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius ?? 24.r,
                              ),
                            )
                            : OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(24.r),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.extra07,
                                width: widget.borderWidth,
                              ),
                            ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius ?? 24.r),
                      ),
                      borderSide: BorderSide(
                        color: AppColors.extra04,
                        width: widget.borderWidth,
                      ),
                    ),
                    enabledBorder:
                        value
                            ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius ?? 24.r,
                              ),
                            )
                            : OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(widget.borderRadius ?? 24.r),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.extra07,
                                width: widget.borderWidth,
                              ),
                            ),
                    focusedBorder:
                        value
                            ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius ?? 24.r,
                              ),
                            )
                            : OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(widget.borderRadius ?? 24.r),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.text01,
                                width: widget.borderWidth,
                              ),
                            ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 12.w,
                    ),
                    suffixIcon: widget.suffixIcon,
                  ),
                ),
              ),
            );
          },
        ),
        if (widget.errorText?.isNotEmpty == true) ...[
          2.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              widget.errorText!,
              style: AppTextStyles.body4Regular12(color: AppColors.extra04),
            ),
          ),
        ],
      ],
    );
  }
}
