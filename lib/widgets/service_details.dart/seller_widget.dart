import 'package:b2b_partenership/controller/service_details_controller.dart';
import 'package:b2b_partenership/core/functions/get_year_date.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/about_content_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SellerWidget extends StatelessWidget {
  const SellerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServiceDetailsController());
    return GetBuilder<ServiceDetailsController>(builder: (controller) {
      return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            InkWell(
              // onTap: () {
              //   Get.toNamed(AppRoutes.providerProfile, arguments: {
              //     'id': controller.service!.provider!.providerId
              //   });
              // },
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 26.r,
                    backgroundImage: CachedNetworkImageProvider(
                        controller.service!.provider!.image),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.service!.provider!.name,
                        style: getMediumStyle(context).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            controller.service!.provider!.rating.toString(),
                            style: getMediumStyle(context).copyWith(
                                color: blackColor, fontWeight: FontWeight.w500),
                          ),
                          Gap(4),
                          RatingBar.builder(
                            ignoreGestures: true,
                            itemSize: 20.r,
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemBuilder: (context, _) =>
                                Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(20),
            Container(
              padding: EdgeInsets.all(20),
              height: 144.h,
              decoration: BoxDecoration(
                color: lightPrimaryColor.withAlpha(160),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleWidget("Country".tr,
                          icon: CupertinoIcons.location_fill),
                      Gap(10),
                      valueWidget(translateDatabase(
                          arabic: controller.service!.provider!.countryNameAr,
                          english:
                              controller.service!.provider!.countryNameEn)),
                      Spacer(),
                      titleWidget("Provider type".tr),
                      Gap(10),
                      valueWidget(translateDatabase(
                          arabic:
                              controller.service!.provider!.providerTypeNameAr,
                          english: controller
                              .service!.provider!.providerTypeNameEn)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleWidget("City".tr, icon: Icons.location_on_sharp),
                      Gap(10),
                      valueWidget(
                        translateDatabase(
                            arabic:
                                controller.service!.provider!.governmentNameAr,
                            english:
                                controller.service!.provider!.governmentNameEn),
                      ),
                      Spacer(),
                      titleWidget("Seller Since".tr),
                      Gap(10),
                      valueWidget(
                          getYear(controller.service!.provider!.createdAt.toString())
                              .toString()),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
