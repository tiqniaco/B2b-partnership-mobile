import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/constants/app_constants.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
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
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(40),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          border: Border(
              top: BorderSide(width: 0.5, color: Colors.grey.withAlpha(80))),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    errorWidget: (context, url, error) => CircleAvatar(
                      child: Icon(CupertinoIcons.person),
                    ),
                  ),
                ),
                Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name!,
                        style: getMediumStyle(context).copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        model.createdAt!,
                        style: getLightStyle(context).copyWith(
                          color: Colors.green,
                          fontWeight: FontManager.regularFontWeight,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(10),
                //  Spacer(),
                Text(model.status!,
                    style: TextStyle(
                        fontSize: 15.r,
                        color: Colors.green,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Gap(5.h),
            Divider(),
            Gap(5.h),
            Row(
              children: [
                Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.description!,
                        textAlign: TextAlign.start,
                        style: getRegularStyle(context).copyWith(
                          color: Colors.black,
                          // fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(5),
                      Row(
                        children: [
                          Text(
                            translateDatabase(
                                arabic: model.specializationNameAr!,
                                english: model.specializationNameEn!),
                            style: getLightStyle(context).copyWith(
                              color: greyColor,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Spacer(),
                          SizedBox(
                            width: 120.w,
                            height: 25.h,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                padding: WidgetStatePropertyAll(
                                    EdgeInsets.symmetric(horizontal: 10)),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5.r),
                                      topLeft: Radius.circular(5.r),
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.toNamed(AppRoutes.serviceRequestDetails,
                                    arguments: {"model": model});
                              },
                              child: Text(
                                "Show Service".tr,
                                style: getLightStyle(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            // Gap(10),
            if (model.image != null)
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5.r),
                  bottomRight: Radius.circular(5.r),
                  topLeft: Radius.circular(5.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: "$kBaseImageUrl${model.image}",
                  height: 120.h,
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
