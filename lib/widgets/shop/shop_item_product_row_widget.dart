import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:b2b_partenership/models/shop_product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShopItemProductRowWidget extends StatelessWidget {
  const ShopItemProductRowWidget({
    super.key,
    required this.product,
    required this.onTap,
  });

  final ShopProductModel product;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.isTablet ? 200 : 134,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 128,
                height: context.isTablet ? 200 : 134,
                decoration: BoxDecoration(
                  borderRadius: customBorderRadius,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        product.image,
                      ),
                      fit: BoxFit.cover),
                  border: Border.all(
                    color: borderColor,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 14.r,
                      backgroundColor: whiteColor,
                      child: Icon(
                        Icons.shopping_cart,
                        color: primaryColor,
                        size: 18.r,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: context.isTablet ? 170 : 110,
                padding: EdgeInsets.only(
                    left: Get.locale?.languageCode == "en" ? 10 : 0,
                    right: Get.locale?.languageCode == "en" ? 0 : 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: blackColor,
                    width: 0.2.w,
                  ),
                  borderRadius: customOneRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product.discount != "0")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.r,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: customOneRadius,
                            ),
                            child: Text(
                              "-${product.discount}%",
                              style: TextStyle(
                                fontSize: 14.r,
                                fontWeight: FontManager.boldFontWeight,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    Gap(2),
                    Text(
                      translateDatabase(
                        arabic: product.descriptionAr,
                        english: product.descriptionEn,
                      ),
                      style: TextStyle(
                          height: 1,
                          fontSize: 16.r,
                          fontWeight: FontWeight.w400,
                          color: blackColor),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(8),
                    Row(
                      children: [
                        Text(
                          product.discount != "0"
                              ? "${double.parse(product.price) - (double.parse(product.discount) / 100 * double.parse(product.price))}\$"
                              : "${product.price}\$",
                          style: getLightStyle(context).copyWith(
                            fontWeight: FontManager.mediumFontWeight,
                            fontSize: 14.r,
                            color: primaryColor,
                          ),
                        ),
                        Gap(8),
                        if (product.discount != "0")
                          Text(
                            "${product.price}\$",
                            style: getMediumStyle(context).copyWith(
                              fontSize: 12.r,
                              color: blackColor.withAlpha(150),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
