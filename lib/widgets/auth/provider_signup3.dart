import 'package:b2b_partenership/controller/auth/signup_controller.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'auth_text_form.dart';

class ProviderSignup3 extends StatelessWidget {
  const ProviderSignup3({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return GetBuilder<SignupController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthTextForm(
            lable: "Bio".tr,
            minLines: 4,
            maxLines: 10,
            preicon: CupertinoIcons.person,
            hintText: "Description of the Company ....".tr,
            textFormController: controller.bioController,
            validator: (val) {
              return controller.validUserData(val);
            },
          ),
          Gap(20),
          if (controller.selectedType.nameEn != "Freelancer") ...[
            AuthTextForm(
              lable: "Value added tax (VAT)".tr,
              hintText: "add the number here".tr,
              textFormController: controller.vatController,
              // validator: (val) {
              //   return controller.validUserData(val);
              // },
            ),
            Gap(20),
            AuthTextForm(
              lable: "Commercial Register Number".tr,
              hintText: "add the number here".tr,
              textFormController: controller.commercialNumberController,
              // validator: (val) {
              //   return controller.validUserData(val);
              // },
            ),
            Gap(20),
            AuthTextForm(
              lable: "Tax Number".tr,
              hintText: "add the number here".tr,
              textFormController: controller.taxNumberController,
              // validator: (val) {
              //   return controller.validUserData(val);
              // },
            ),
            Gap(20),
            AuthTextForm(
              enabled: false,
              lable: "Commercial Register".tr,
              preicon: CupertinoIcons.person,
              hintText: "No file selected   ".tr,
              textFormController: controller.commercialController,
              // validator: (val) {
              //   return controller.validUserData(val);
              // },
              sufix: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.commercePdfFile != null)
                      InkWell(
                        onTap: () {
                          controller.removeFile("c");
                        },
                        child: Icon(
                          Icons.close,
                          size: 23.r,
                        ),
                      ),
                    Gap(5),
                    SizedBox(
                      width: context.isTablet ? 45.w : 80.w,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.pickPDF("c");
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: Text(
                          "Upload".tr,
                          style: getLightStyle(context).copyWith(
                            color: whiteColor,
                            fontWeight: FontManager.mediumFontWeight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(20),
            AuthTextForm(
              enabled: false,
              lable: "Tax Card".tr,
              preicon: CupertinoIcons.person,
              hintText: "No file selected   ".tr,
              textFormController: controller.taxCartController,
              // validator: (val) {
              //   return controller.validUserData(val);
              // },
              sufix: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.taxPdfFile != null)
                      InkWell(
                        onTap: () {
                          //print("hi");
                          controller.removeFile("t");
                        },
                        child: Icon(
                          Icons.close,
                          size: 23.r,
                        ),
                      ),
                    Gap(5),
                    SizedBox(
                      width: context.isTablet ? 45.w : 80.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              //padding: EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          onPressed: () {
                            controller.pickPDF(
                              "t",
                            );
                          },
                          child: Text(
                            "Upload".tr,
                            style: getLightStyle(context).copyWith(
                              color: whiteColor,
                              fontWeight: FontManager.mediumFontWeight,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
          // Gap(20),
        ],
      ),
    );
  }
}
