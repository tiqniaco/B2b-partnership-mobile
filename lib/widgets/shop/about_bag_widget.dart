import 'package:b2b_partenership/controller/shop/shop_product_details_controller.dart';
import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/functions/responsive_font.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/services/responsive_helper.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AboutBagWidget extends StatelessWidget {
  const AboutBagWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopProductDetailsController>(
      builder: (controller) {
        final hasProduct = controller.product != null;
        final contents = controller.contents;
        if (!hasProduct && contents.isEmpty) {
          return const SizedBox.shrink();
        }
        final titleEn = controller.product?.titleEn ?? "";
        final descriptionEn = controller.product?.descriptionEn ?? "";
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(8),
            Text("Bag Contents".tr,
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 12.rf(), fontWeight: FontWeight.bold)),
            Gap(8),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: ResponsiveHelper.getValue(
                      thinValue: 0.9, // 393
                      extraSmallValue: 1, // 450
                      smallValue: 1.3, // 600
                      mediumValue: 1.5, // 900
                      largeValue: 1.8, // 1200
                      extraLargeValue: 2.4)),
              itemBuilder: (context, index) => Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: controller.contents[index].image ?? "",
                    height: context.isTablet ? 140 : 70.h,
                  ),
                  Gap(8),
                  Text(
                      translateDatabase(
                          arabic: controller.contents[index].nameAr ?? "",
                          english: controller.contents[index].nameEn ?? ""),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11.rf(), fontWeight: FontWeight.bold))
                ],
              ),
              shrinkWrap: true,
              itemCount: contents.length,
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
                  Directionality(
                    textDirection: containsArabic(titleEn)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: Text(titleEn,
                        style: TextStyle(
                            fontSize: 13.rf(),
                            color: primaryColor,
                            height: 1.5,
                            fontWeight: FontWeight.bold)),
                  ),
                  Gap(12),
                  Directionality(
                    textDirection: containsArabic(descriptionEn)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: QuillEditor.basic(
                      controller: controller.controller,
                      config: QuillEditorConfig(
                        scrollable: false,
                        autoFocus: false,
                        expands: false,
                        customStyles: DefaultStyles(
                          paragraph: DefaultTextBlockStyle(
                              TextStyle(
                                  fontSize: 13.rf(),
                                  color: blackColor,
                                  height: 1.6,
                                  fontWeight: FontWeight.normal),
                              HorizontalSpacing(0, 0),
                              VerticalSpacing(0, 0),
                              VerticalSpacing(0, 0),
                              null),
                        ),
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
