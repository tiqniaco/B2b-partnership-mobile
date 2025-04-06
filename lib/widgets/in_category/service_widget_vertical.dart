import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
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
                          child: CustomNetworkImage(
                            imageUrl: services[index].image!,
                            height: 90.h,
                            width: context.isTablet ? 90.w : 110.w,
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
                                style: getRegularStyle(context).copyWith(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Gap(3.h),
                              Text(
                                translateDatabase(
                                    arabic:
                                        services[index].specializationNameAr!,
                                    english:
                                        services[index].specializationNameEn!),
                                style: getLightStyle(context).copyWith(
                                    color: greyColor,
                                    fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Gap(5.h),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Visibility(
                                      visible: Get.find<AppPreferences>()
                                              .getUserRole() ==
                                          "provider",
                                      child: SizedBox(
                                        height: 32.h,
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
                                            "Edit".tr,
                                            style: TextStyle(fontSize: 11.sp),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(4.w),
                                  Expanded(
                                    flex: context.isTablet ? 1 : 2,
                                    child: SizedBox(
                                      height: 32.h,
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
                                          "View".tr,
                                          style:
                                              getRegularStyle(context).copyWith(
                                            fontWeight:
                                                FontManager.mediumFontWeight,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
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
