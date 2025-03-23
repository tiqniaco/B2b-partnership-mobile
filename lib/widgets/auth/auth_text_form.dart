import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuthTextForm extends StatelessWidget {
  const AuthTextForm({
    super.key,
    required this.hintText,
    this.suficon,
    this.textFormController,
    this.validator,
    this.keyboardType,
    this.obscureText,
    this.preicon,
    this.onTapIconsuf,
    this.sufcolor,
    required this.lable,
    this.formBorderColor = pageColor,
    this.minLines,
    this.maxLines,
    this.sufix,
    this.enabled,
  });
  final Color? sufcolor;
  final String hintText;
  final IconData? suficon;
  final IconData? preicon;
  final TextEditingController? textFormController;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? lable;
  final void Function()? onTapIconsuf;
  final Color? formBorderColor;
  final int? minLines;
  final int? maxLines;
  final Widget? sufix;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      validator: validator,
      keyboardType: keyboardType,
      maxLength: null,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      controller: textFormController,
      onChanged: (val) {},
      inputFormatters: [
        if (enabled != null && !enabled!) FilteringTextInputFormatter.allow(""),
      ],
      decoration: InputDecoration(
        // enabled: enabled ?? true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.isTablet ? 10.w : 12.w,
          vertical: 12.h,
        ),
        label: Text(
          lable!,
          style: getMediumStyle(context).copyWith(
            color: Colors.black87,
          ),
        ),
        floatingLabelStyle: getRegularStyle(context),
        labelStyle: getSemiBoldStyle(context).copyWith(
          fontWeight: FontManager.regularFontWeight,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: const BorderSide(color: blackColor, width: 1),
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: sufix ??
            (suficon != null
                ? InkWell(
                    onTap: onTapIconsuf,
                    child: Icon(
                      suficon,
                      color: sufcolor,
                      size: context.isTablet ? 11.sp : 18.sp,
                    ),
                  )
                : null),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: formBorderColor!, width: 1.5),
          borderRadius: BorderRadius.circular(7.0),
        ),
        hintText: hintText.tr,
        hintStyle: getLightStyle(context).copyWith(
          color: greyColor.withAlpha(160),
          fontWeight: FontWeight.bold,
        ),
        errorStyle: getLightStyle(context),
      ),
    );
  }
}
