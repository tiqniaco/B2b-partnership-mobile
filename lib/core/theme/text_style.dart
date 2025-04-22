import 'package:get/get.dart';

import '/core/theme/app_color.dart';
import '../utils/font_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

TextStyle _getTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight = FontWeight.normal,
  FontStyle fontStyle = FontStyle.normal,
}) {
  return TextStyle(
    color: color ?? blackColor,
    fontSize: fontSize ?? 16.sp,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    overflow: TextOverflow.ellipsis,
  );
}

TextStyle getBoldStyle(BuildContext context) {
  return _getTextStyle(
    fontWeight: FontManager.mediumFontWeight,
    fontSize: context.isTablet ? 14.sp : 21.sp,
    color: blackColor,
  );
}

TextStyle getSemiBoldStyle(BuildContext context) {
  return _getTextStyle(
    fontWeight: FontManager.mediumFontWeight,
    fontSize: context.isTablet ? 12.sp : 18.sp,
    color: blackColor,
  );
}

TextStyle getMediumStyle(BuildContext context) {
  return _getTextStyle(
    fontWeight: FontManager.regularFontWeight,
    fontSize: context.isTablet ? 10.sp : 16.sp,
    color: blackColor,
  );
}

TextStyle getRegularStyle(BuildContext context) {
  return _getTextStyle(
    fontWeight: FontManager.regularFontWeight,
    fontSize: context.isTablet ? 8.sp : 14.sp,
    color: blackColor,
  );
}

TextStyle getLightStyle(BuildContext context) {
  return _getTextStyle(
    fontWeight: FontManager.lightFontWeight,
    fontSize: context.isTablet ? 7.sp : 12.sp,
    color: blackColor,
  );
}
