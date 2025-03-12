import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/models/services_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ServiceWidgetVertical extends StatelessWidget {
  const ServiceWidgetVertical({
    super.key,
    required this.services,
  });
  final List<ServiceModelData> services;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 12.w,
        ),
        itemCount: services.length,
        separatorBuilder: (context, index) => Gap(16.h),
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.serviceDetails,
                    arguments: {"id": services[index].id});
              },
              child: Container(
                height: 120.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.grey.withAlpha(80),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: services[index].image!,
                            height: 70.h,
                            width: 75.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                services[index].description!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Gap(10),
                              Row(
                                children: [
                                  Text(
                                    translateDatabase(
                                        arabic: services[index]
                                            .specializationNameAr!,
                                        english: services[index]
                                            .specializationNameEn!),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: greyColor,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Gap(8.h),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Visibility(
                                            visible: Get.find<AppPreferences>()
                                                    .getUserRole() ==
                                                "provider",
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                  Colors.green,
                                                ),
                                                padding: WidgetStatePropertyAll(
                                                  EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                ),
                                                shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      5,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                Get.toNamed(
                                                  AppRoutes.editProviderService,
                                                  arguments: {
                                                    "service": services[index],
                                                  },
                                                );
                                              },
                                              child: Text(
                                                "Edit",
                                                style:
                                                    TextStyle(fontSize: 11.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Gap(4.w),
                                        Expanded(
                                          flex: 2,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              padding: WidgetStatePropertyAll(
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10)),
                                              shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Get.toNamed(
                                                AppRoutes.serviceDetails,
                                                arguments: {
                                                  "id": services[index].id,
                                                },
                                              );
                                            },
                                            child: Text(
                                              "View Details",
                                              style: TextStyle(fontSize: 11.sp),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
