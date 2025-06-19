import 'package:b2b_partenership/core/enums/language_enum.dart';
import 'package:b2b_partenership/core/functions/change_app_lang.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/assets_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key, this.gradient});
  final Gradient? gradient;

  /// final LocalController localcontroller = Get.put(LocalController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Colors.black12,
        ),
      ),
      child: InkWell(
        onTap: () {
          Get.bottomSheet(Container(
            height: 0.2.sh,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(
              // horizontal: 10.w,
              vertical: 10.h,
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "English",
                    style: getRegularStyle(context),
                  ),
                  leading: Image.asset(
                    AssetsData.englishImage,
                    width: 20.w,
                  ),
                  onTap: () {
                    changeAppLang(
                      context: Get.context!,
                      lang: LanguageEnum.en,
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'العربية',
                    style: getRegularStyle(context),
                  ),
                  leading: Image.asset(
                    AssetsData.arabicImage,
                    width: 20.w,
                  ),
                  onTap: () {
                    changeAppLang(
                      context: Get.context!,
                      lang: LanguageEnum.ar,
                    );
                  },
                ),
              ],
            ),
          ));
        },
        child: Row(
          children: [
            Icon(
              Icons.language,
              color: primaryColor,
              size: 20.r,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Change Language".tr,
              style: getRegularStyle(Get.context!)
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            Text(
              Get.locale?.languageCode == 'ar'
                  ? 'العربية 🇸🇦'
                  : 'English 🇬🇧',
              style: getRegularStyle(context).copyWith(
                shadows: [
                  const Shadow(
                    blurRadius: 10.0,
                    color: Colors.white, //.withOpacity(0.7),
                    offset: Offset(5.0, 5.0),
                  ),
                ],
                fontVariations: [
                  const FontVariation('wght', 400),
                  const FontVariation('wdth', 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
