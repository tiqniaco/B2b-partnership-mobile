import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:b2b_partenership/models/provider_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderWidget extends StatelessWidget {
  const ProviderWidget({
    super.key,
    required this.provider,
    required this.toggleFavorite,
  });
  final ProviderModel provider;
  final void Function() toggleFavorite;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.providerProfile,
            arguments: {"id": provider.providerId.toString()});
      },
      child: Container(
        width: context.isTablet ? 95.w : 140.w,
        height: 90.h,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withAlpha(80))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: provider.image!,
                    height: 90.h,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Gap(4.h),
                Column(
                  children: [
                    Text(
                      provider.name!,
                      textAlign: TextAlign.center,
                      style: getRegularStyle(context).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    PannableRatingBar(
                      rate: double.parse(provider.rating!),
                      items: List.generate(
                        5,
                        (index) => RatingWidget(
                          selectedColor: Colors.amber,
                          unSelectedColor: Colors.grey,
                          child: Icon(
                            Icons.star,
                            size: context.isTablet ? 12.w : 15.w,
                          ),
                        ),
                      ),
                      onHover: (value) {},
                    ),
                    Gap(2.h),
                    Text(
                      provider.bio!,
                      textAlign: TextAlign.center,
                      style: getLightStyle(context).copyWith(
                        color: Colors.black54,
                        fontSize: context.isTablet ? 8.sp : 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            Gap(3.h),
            Divider(),
            Gap(2.h),
            Row(
              children: [
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!)),
                    padding: EdgeInsets.all(8),
                    child: provider.isFavorite == "1"
                        ? InkWell(
                            onTap: toggleFavorite,
                            child: Icon(
                              size: context.isTablet ? 12.sp : 17.sp,
                              Icons.bookmarks,
                              color: primaryColor,
                            ),
                          )
                        : InkWell(
                            onTap: toggleFavorite,
                            child: Icon(
                              size: context.isTablet ? 12.sp : 17.sp,
                              Icons.bookmarks_outlined,
                              color: Colors.black54,
                            ),
                          ),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: SizedBox(
                    height: context.isTablet ? 28.h : 32.h,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(
                            horizontal: 0,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.toNamed(
                          AppRoutes.providerProfile,
                          arguments: {
                            "id": provider.providerId.toString(),
                          },
                        );
                      },
                      child: Text(
                        "View".tr,
                        style: getLightStyle(context).copyWith(
                          fontWeight: FontManager.boldFontWeight,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
