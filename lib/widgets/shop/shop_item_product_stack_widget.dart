import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:b2b_partenership/models/shop_product_model.dart';
import 'package:b2b_partenership/widgets/shop/price_widget.dart';
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
        height: context.isTablet ? 280 : 230,
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
              child: Container(
                color: primaryColor,
                child: Stack(
                  children: [
                    CustomNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: context.isTablet ? 224 : 160,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                      width: double.infinity,
                      height: context.isTablet ? 224 : 160,
                      decoration: BoxDecoration(
                        borderRadius: customOneRadius,
                        //color: blackColor.withAlpha(170),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withAlpha(200),
                            //Colors.black.withAlpha(180),
                            Colors.transparent,
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          priceRow(product.price, product.discount),
                          Gap(8),
                        ],
                      ),
                    ),
                    if (product.discount != "0")
                      PositionedDirectional(
                        end: 26.w,
                        top: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.r,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(30),
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
            ),
            Gap(12),
            Directionality(
              textDirection: containsArabic(product.descriptionEn)
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Text(
                product.titleEn,
                style: getMediumStyle(context).copyWith(
                    fontWeight: FontManager.mediumFontWeight,
                    height: 1.2,
                    color: blackColor,
                    fontSize: 15.r),
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Gap(8),
          ],
        ),
      ),
    );
  }
}
