import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:b2b_partenership/models/shop_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShopItemProductStackWidget extends StatelessWidget {
  const ShopItemProductStackWidget({
    super.key,
    required this.product,
    required this.onTap,
  });

  final ShopProductModel product;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.isTablet ? 270 : 190,
        width: 1.r,
        decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(12.r)),
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FractionallySizedBox(
              widthFactor: context.isTablet ? 1.1 : 1.2,
              child: Stack(
                children: [
                  CustomNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: context.isTablet ? 264 : 187,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40, vertical: 18.h),
                    width: double.infinity,
                    height: context.isTablet ? 130.h : 130.h,
                    decoration: BoxDecoration(
                      borderRadius: customOneRadius,
                      color: blackColor.withAlpha(170),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withAlpha(180),
                          Colors.black.withAlpha(160),
                          Colors.transparent,
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Directionality(
                            textDirection: containsArabic(product.descriptionEn)
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            child: Text(
                              product.descriptionEn,
                              style: getMediumStyle(context).copyWith(
                                  fontWeight: FontManager.mediumFontWeight,
                                  height: 1,
                                  color: whiteColor),
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Gap(8),
                        Row(
                          children: [
                            Text(
                              product.discount != "0"
                                  ? "${double.parse(product.price) - (double.parse(product.discount) / 100 * double.parse(product.price))}\$"
                                  : "${product.price}\$",
                              style: getBoldStyle(context).copyWith(
                                fontSize: 16.r,
                                color: whiteColor,
                              ),
                            ),
                            Gap(8),
                            if (product.discount != "0")
                              Text(
                                "${product.price}\$",
                                style: getMediumStyle(context).copyWith(
                                    fontSize: 14.r,
                                    color: whiteColor,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: whiteColor),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (product.discount != "0")
                    PositionedDirectional(
                      //start: 0,
                      end: context.isTablet ? 22 : 23.w,
                      child: Container(
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
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
