import 'package:flutter/material.dart';
import 'package:get/get.dart';


String? languageCode = Get.locale?.languageCode;
//languageCode=='ar'? "Cairo" :
class FontManager {
  
  static  String defaultFontFamily =  'Roboto'; 

  static const FontWeight lightFontWeight = FontWeight.w300;
  static const FontWeight regularFontWeight = FontWeight.w400;
  static const FontWeight mediumFontWeight = FontWeight.w500;
  static const FontWeight semiBoldFontWeight = FontWeight.w600;
  static const FontWeight boldFontWeight = FontWeight.w700;
}
