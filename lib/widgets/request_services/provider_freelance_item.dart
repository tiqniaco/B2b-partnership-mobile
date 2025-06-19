import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/constants/app_constants.dart';
import 'package:b2b_partenership/core/services/date_time_convertor.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:b2b_partenership/models/service_request_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderFreelanceItem extends StatelessWidget {
  const ProviderFreelanceItem({super.key, required this.model});
  final ServiceRequestModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.serviceRequestDetails,
            arguments: {"model": model});
      },
      child: Container(
        decoration: BoxDecoration(
          color: lightPrimaryColor.withAlpha(170),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: CachedNetworkImage(
                                imageUrl: model.clientImage!,
                                height: 40.h,
                                width: 40.h,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  child: Icon(CupertinoIcons.person),
                                ),
                              ),
                            ),
                            Gap(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.name!,
                                  style: getMediumStyle(context).copyWith(
                                    color: Colors.black,
                                    fontSize: 16.r,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  DateTimeConvertor.timeAgo(model.createdAt!),
                                  style: getLightStyle(context).copyWith(
                                    color: Colors.black,
                                    fontWeight: FontManager.regularFontWeight,
                                    fontSize: 10.r,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Gap(5),
                        Text(
                          model.description!,
                          textAlign: TextAlign.start,
                          style: getRegularStyle(context).copyWith(
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Gap(8),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: context.isTablet ? 150 : 95,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                        decoration: BoxDecoration(
                            borderRadius: customBorderRadius,
                            color: primaryColor),
                        child: Text("Show".tr,
                            style: TextStyle(
                              fontSize: 12.r,
                              color: whiteColor,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Gap(10),
                      Container(
                        alignment: Alignment.center,
                        width: context.isTablet ? 150 : 95,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                                .copyWith(),
                        decoration: BoxDecoration(
                            borderRadius: customBorderRadius,
                            border: Border.all(color: primaryColor)),
                        child: Text(model.status!.tr,
                            style: TextStyle(
                                fontSize: 12.r,
                                color: primaryColor,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(10),
            if (model.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(17.r),
                child: CachedNetworkImage(
                  imageUrl: "$kBaseImageUrl${model.image}",
                  height: 150.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Text("${model.image}"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
