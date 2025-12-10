import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CustomNoConnectionWidget extends StatelessWidget {
  const CustomNoConnectionWidget({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        //height: 0.25.sh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 100.r,
              color: greyColor,
            ),
            Gap(8),
            Text(
              Get.locale?.languageCode == 'ar'
                  ? 'لا يوجد اتصال بالانترنت'
                  : 'No Internet Connection',
              style: getMediumStyle(
                context,
              ).copyWith(color: blackWithOpacityColor),
            ),
            Gap(24),
            if (onTap != null)
              SizedBox(
                width: 150.w,
                height: 45,
                child: CustomLoadingButton(
                  borderRadius: 12,
                  onPressed: () {
                    onTap?.call();
                  },
                  text: 'Retry!'.tr,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
