import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/functions/responsive_font.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/provider_model.dart';
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
        width: context.isTablet ? 95.w : 163.w,
        height: 92.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withAlpha(40),
          ),
          color: whiteColor,
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CustomNetworkImage(
                        borderRadius: 8,
                        imageUrl: provider.image,
                        height: 66.h,
                        width: 66.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -2,
                    left: 8,
                    child: InkWell(
                      child: provider.isFavorite == "1"
                          ? InkWell(
                              onTap: toggleFavorite,
                              child: Icon(
                                size: 20.r,
                                Icons.bookmark,
                                color: primaryColor,
                              ),
                            )
                          : InkWell(
                              onTap: toggleFavorite,
                              child: Icon(
                                size: 20.r,
                                Icons.bookmark_outline_rounded,
                                color: primaryColor,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      provider.name.toUpperCase(),
                      textDirection: containsArabic(provider.name)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: getRegularStyle(context).copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.rf(),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    PannableRatingBar(
                      rate: double.parse(provider.rating.toString()),
                      items: List.generate(
                        5,
                        (index) => RatingWidget(
                          selectedColor: Colors.amber,
                          unSelectedColor: Colors.grey,
                          child: Icon(
                            Icons.star,
                            size: 14.r,
                          ),
                        ),
                      ),
                      onHover: (value) {},
                    ),
                    Gap(4),
                    Text(
                      provider.bio,
                      textDirection: containsArabic(provider.bio)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: getLightStyle(context).copyWith(
                        color: Colors.black54,
                        fontSize: 13.rf(),
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(4),
                    SizedBox(
                      height: 32.h,
                      child: CustomLoadingButton(
                        borderRadius: 10.r,
                        height: 32.h,
                        onPressed: () {
                          Get.toNamed(AppRoutes.providerProfile, arguments: {
                            "id": provider.providerId.toString()
                          });
                        },
                        fontSize: 12.rf(),
                        text: "View".tr,
                      ),
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
