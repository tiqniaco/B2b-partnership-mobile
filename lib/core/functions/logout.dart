import 'package:b2b_partenership/core/enums/language_enum.dart';
import 'package:b2b_partenership/core/functions/change_app_lang.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';

Future<void> logoutDialog(BuildContext context) async {
  Get.defaultDialog<bool>(
    title: 'Logout?'.tr,
    middleText: 'Are you sure you want to logout?'.tr,
    textConfirm: 'Yes'.tr,
    confirmTextColor: whiteColor,
    textCancel: 'No'.tr,
    onConfirm: () {
      logout(context);
    },
  );
}

Future<void> logout(BuildContext context) async {
  kFirstTime = true;
  ApiConstance.token = '';

  await Get.find<AppPreferences>().clear();

  changeAppLang(lang: LanguageEnum.en, context: context);
}
