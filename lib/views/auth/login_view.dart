import 'package:b2b_partenership/controller/auth/login_controller.dart';
import 'package:b2b_partenership/core/enums/language_enum.dart';
import 'package:b2b_partenership/core/functions/change_app_lang.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/assets_data.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';
import '../../widgets/auth/auth_text_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      backgroundColor: whiteColor,
      body: SizedBox(
        height: 1.sh,
        child: SingleChildScrollView(
          child: SafeArea(
            bottom: false,
            child: GetBuilder<LoginController>(
              init: LoginController(),
              builder: (controller) => Form(
                key: controller.loginFormKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      margin: EdgeInsetsDirectional.only(
                        top: 10.h,
                      ),
                      alignment: AlignmentDirectional.centerEnd,
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Get.locale?.languageCode == 'ar'
                                  ? 'العربية'
                                  : 'English',
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
                            Gap(5.w),
                            Image.asset(
                              Get.locale?.languageCode == 'ar'
                                  ? AssetsData.arabicImage
                                  : AssetsData.englishImage,
                              width: 16.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(0.05.sh),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 130.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gap(10.h),
                          Text(
                            "Welcome Back!".tr,
                            style: getSemiBoldStyle(context),
                          ),
                          Text(
                            "Login with your email or phone and password".tr,
                            style: getLightStyle(context).copyWith(
                              color: Colors.black54,
                            ),
                          ),
                          Gap(0.03.sh),
                          AuthTextForm(
                            validator: (val) {
                              return controller.validUserData(val);
                            },
                            textFormController: controller.loginController,
                            lable: "Email or Phone".tr,
                            preicon: CupertinoIcons.phone,
                            hintText: "Enter your email or phone".tr,
                          ),
                          Gap(20.h),
                          AuthTextForm(
                            validator: (val) {
                              return controller.validUserData(val);
                            },
                            textFormController: controller.passwordController,
                            onTapIconsuf: () {
                              controller.ontapSupfix();
                            },
                            obscureText: controller.obscureText,
                            lable: "Password".tr,
                            sufcolor: Colors.black54,
                            suficon: controller.obscureText
                                ? Icons.remove_red_eye_outlined
                                : Icons.visibility_off_outlined,
                            preicon: CupertinoIcons.lock,
                            hintText: "Enter password".tr,
                          ),
                          Gap(10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.forgetPassword);
                                },
                                child: Text(
                                  "Forget Password?".tr,
                                  style: getRegularStyle(context).copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(0.03.sh),
                          SizedBox(
                            height: 38.h,
                            child: CustomLoadingButton(
                              text: "Login".tr,
                              onPressed: () {
                                return controller.login();
                              },
                              backgroundColor: primaryColor,
                              height: 0.06.sh,
                            ),
                          ),
                          Gap(0.02.sh),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have account?".tr,
                                style: getRegularStyle(context).copyWith(
                                  fontWeight: FontManager.regularFontWeight,
                                  color: Colors.black54,
                                ),
                              ),
                              Gap(5.w),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.chooseAccount);
                                },
                                child: Text(
                                  "Create New".tr,
                                  style: getMediumStyle(context).copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Get.toNamed(AppRoutes.clientHomeLayout);
                          //   },
                          //   child: Text(
                          //     "home".tr,
                          //     style: TextStyle(
                          //       fontSize: 13.sp,
                          //       fontWeight: FontWeight.w500,
                          //       color: blackColor,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
