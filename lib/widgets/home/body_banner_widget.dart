import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BodyBannerWidget extends StatelessWidget {
  const BodyBannerWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.buttonTitle,
      required this.onPressed});
  final String image;
  final String title;

  final String buttonTitle;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 0),
        borderRadius: customBorderRadius,
      ),
      height: context.isTablet ? 230 : 164,
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: customBorderRadius,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: customBorderRadius,
              gradient: LinearGradient(
                begin: Get.locale?.languageCode == "en"
                    ? Alignment.topLeft
                    : Alignment.topRight,
                end: Get.locale?.languageCode == "en"
                    ? Alignment.bottomRight
                    : Alignment.bottomLeft,
                colors: [
                  const Color.fromARGB(255, 93, 1, 1).withAlpha(100),
                  Color.fromARGB(255, 83, 3, 3).withAlpha(95),
                  Color.fromARGB(255, 83, 3, 3).withAlpha(80),
                  blackColor.withAlpha(50),
                  blackColor.withAlpha(50),
                  blackColor.withAlpha(40),
                ],
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                      fontFamily: 'PlaypenSans',
                      fontSize: 19.r,
                    ),
                  ),
                  Gap(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: context.isTablet ? 50 : 36,
                        width: 100.r,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 16),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                              primaryColor,
                            ),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: customBorderRadius),
                            ),
                          ),
                          onPressed: onPressed,
                          child: Text(
                            buttonTitle,
                            style: getLightStyle(context).copyWith(
                                fontFamily: 'PlaypenSans',
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                                fontSize: 13.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(10)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
