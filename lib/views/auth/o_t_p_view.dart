import 'package:b2b_partenership/controller/auth/otp_controller.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/assets_data.dart';

import 'package:lottie/lottie.dart';

import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPView extends StatelessWidget {
  const OTPView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OTPController>(
      init: OTPController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("Verification Code".tr),
        ),
        body: Container(
          width: 1.sw,
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 0.3.sh,
                child: Lottie.asset(
                  AssetsData.loadingAnimation,
                  repeat: true,
                  height: 0.2.sh,
                ),
              ),
              Text(
                "Please enter your an OTP to\n reset your password".tr,
                textAlign: TextAlign.center,
                style: getMediumStyle,
                maxLines: 3,
              ),
              Gap(24.h),
              Directionality(
                textDirection: TextDirection.ltr,
                child: OtpTextField(
                  numberOfFields: 6,
                  borderColor: primaryColor,
                  focusedBorderColor: primaryColor,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  fillColor: whiteColor,
                  filled: true,

                  fieldWidth: 0.128.sw,
                  // styles: [
                  //   getSemiBoldStyle,
                  //   getSemiBoldStyle,
                  //   getSemiBoldStyle,
                  //   getSemiBoldStyle,
                  //   getSemiBoldStyle,
                  //   getSemiBoldStyle,
                  // ],
                  contentPadding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(10),
                  showFieldAsBox: true,
                  keyboardType: TextInputType.number,
                  textStyle: getSemiBoldStyle.copyWith(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  onCodeChanged: (String code) {
                    controller.onCodeChange(code);
                  },
                  onSubmit: (String verificationCode) {
                    controller.onCodeSubmit(verificationCode);
                  }, // end onSubmit
                ),
              ),
              Gap(15.h),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Re Send'.tr,
                    textAlign: TextAlign.start,
                    style: getSemiBoldStyle.copyWith(
                        color: secondaryColor, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
