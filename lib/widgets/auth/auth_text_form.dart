import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/material.dart';
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
    // this.autofocus,
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

  //final bool? autofocus;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      validator: validator,
      //keyboardAppearance: Brightness.dark,
      keyboardType: keyboardType,
      //autofocus: autofocus!,

      maxLength: null,
      controller: textFormController,
      onChanged: (val) {},
      //style: TextStyle(fontSize: 10.sp), // getRegularStyle,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.isTablet ? 10.w : 12.w,
          vertical: context.isTablet ? 15.h : 12.h,
        ),
        //label: Text("phone"),
        //labelText: lable,
        label: Text(
          lable!,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17.sp,
              color: Colors.black87),
        ),
        floatingLabelStyle: getRegularStyle,
        labelStyle: TextStyle(fontSize: 18.sp),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: const BorderSide(color: blackColor, width: 1),
        ),
        // prefixIcon: Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: Icon(
        //     preicon,
        //     color: Colors.black,
        //     size: context.isTablet ? 11.sp : 18.sp,
        //   ),
        // ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: InkWell(
          onTap: onTapIconsuf,
          child: Icon(
            suficon,
            color: sufcolor,
            size: context.isTablet ? 11.sp : 18.sp,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: formBorderColor!, width: 1.5),
          borderRadius: BorderRadius.circular(7.0),
        ),
        hintText: hintText.tr,
        hintStyle: TextStyle(
            fontSize: 12.sp,
            color: greyColor.withAlpha(160),
            fontWeight: FontWeight.bold),
        errorStyle: TextStyle(fontSize: 10.sp),
      ),
    );
  }
}
