import 'package:b2b_partenership/controller/shop/shop_product_details_controller.dart';
import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AboutBagWidget extends StatelessWidget {
  const AboutBagWidget({
    super.key,
    // required this.content,
  });
  // final List<BagContentModel> content;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopProductDetailsController>(
      init: ShopProductDetailsController(),
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(8),
          Text("Bag Contents".tr,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.r, fontWeight: FontWeight.bold)),
          Gap(8),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: context.isTablet ? 1.7 : 0.89),
            itemBuilder: (context, index) => Column(
              children: [
                CachedNetworkImage(
                  imageUrl: controller.contents[index].image!,
                  height: context.isTablet ? 140 : 100,
                ),
                Gap(8),
                Text(
                    translateDatabase(
                        arabic: controller.contents[index].nameAr!,
                        english: controller.contents[index].nameEn!),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 14.r, fontWeight: FontWeight.bold))
              ],
            ),
            shrinkWrap: true,
            itemCount: controller.contents.length,
            physics: const NeverScrollableScrollPhysics(),
          ),
          Gap(24),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: lightPrimaryColor.withAlpha(130),
                borderRadius: BorderRadius.circular(8.r)),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Directionality(
                    textDirection: containsArabic(controller.product!.titleAr)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: Text(controller.product!.titleAr,
                        style: TextStyle(
                            fontSize: 14.r, color: primaryColor, height: 1.5)),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Directionality(
                    textDirection:
                        containsArabic(controller.product!.descriptionAr)
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                    child: Text(controller.product!.descriptionAr,
                        style: TextStyle(
                            fontSize: 14.r,
                            color: Colors.black87,
                            height: 1.5)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
