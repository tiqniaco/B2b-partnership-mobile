import 'package:b2b_partenership/controller/shop/shop_product_details_controller.dart';
import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopProductDetailsController>(
      builder: (controller) {
        final String terms = controller.product?.termsAndConditionsAr ?? "";
        if (terms.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(8),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: lightPrimaryColor.withAlpha(130),
                  borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.safety_check,
                        color: primaryColor,
                        size: 24.r,
                      ),
                      Gap(8),
                      Text(
                        "Terms and Conditions".tr,
                        style: TextStyle(
                            fontSize: 18.r,
                            fontWeight: FontWeight.bold,
                            color: blackColor,
                            height: 1.5),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Directionality(
                      textDirection: containsArabic(terms)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      child: Text(
                        terms,
                        style: TextStyle(
                            fontSize: 14.r, color: Colors.black87, height: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
