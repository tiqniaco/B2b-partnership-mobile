import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
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
            color: Colors.grey.withAlpha(80),
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
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -4,
                    left: 8,
                    child: InkWell(
                      child: provider.isFavorite == "1"
                          ? InkWell(
                              onTap: toggleFavorite,
                              child: Icon(
                                size: 28.r,
                                Icons.bookmark,
                                color: primaryColor,
                              ),
                            )
                          : InkWell(
                              onTap: toggleFavorite,
                              child: Icon(
                                size: 28.r,
                                Icons.bookmark_outline_rounded,
                                color: primaryColor,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: getRegularStyle(context).copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  PannableRatingBar(
                    rate: double.parse(provider.rating),
                    items: List.generate(
                      5,
                      (index) => RatingWidget(
                        selectedColor: Colors.amber,
                        unSelectedColor: Colors.grey,
                        child: Icon(
                          Icons.star,
                          size: 20.r,
                        ),
                      ),
                    ),
                    onHover: (value) {},
                  ),
                  Gap(14),
                  Text(
                    provider.bio,
                    textAlign: TextAlign.center,
                    style: getLightStyle(context).copyWith(
                      color: Colors.black54,
                      fontSize: 14.r,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(10),
                  SizedBox(
                    height: context.isTablet ? 60 : 32,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
