import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black12.withAlpha(10)),
        child: Row(
          children: [
            InkWell(
                onTap: () {},
                child: Icon(
                  CupertinoIcons.search,
                  color: greyColor,
                  size: 21.h,
                )),
            Gap(20),
            Text(
              "Search ...".tr,
              style: TextStyle(
                fontSize: context.isTablet ? 10.sp : 13.sp,
                color: const Color.fromARGB(255, 124, 124, 124),
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Icon(
              FontAwesomeIcons.sliders,
              size: 15.h,
              color: greyColor,
            )
          ],
        ),
      ),
    );
  }
}
