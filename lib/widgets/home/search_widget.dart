// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/themes.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    this.onTap,
    required this.title,
  });
  final void Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
            borderRadius: customBorderRadius,
            border: Border.all(
              color: Colors.grey.withAlpha(190),
            )),
        child: Row(
          children: [
            Gap(15),
            InkWell(
                onTap: () {},
                child: Icon(
                  CupertinoIcons.search,
                  color: primaryColor,
                  size: 16.r,
                )),
            Gap(10),
            Text(
              title.tr,
              style: TextStyle(
                fontSize: context.isTablet ? 10.sp : 13.sp,
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Container(
              height: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: customBorderRadius,
                color: primaryColor,
              ),
              child: Icon(
                FontAwesomeIcons.sliders,
                size: 15.h,
                color: whiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
