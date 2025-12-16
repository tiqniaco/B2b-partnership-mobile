import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:b2b_partenership/models/services_model.dart';
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
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: services.length,
        separatorBuilder: (context, index) => Gap(16.h),
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.serviceDetails,
                    arguments: {"id": services[index].id});
              },
              child: Container(
                height: 116.h,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.grey.withAlpha(160),
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
                            height: 100.h,
                            width: context.isTablet ? 90.w : 110.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gap(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                services[index].description!,
                                textDirection:
                                    containsArabic(services[index].description!)
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 14.r,
                                    fontWeight: FontWeight.w500),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Gap(8),
                              Text(
                                translateDatabase(
                                    arabic:
                                        services[index].specializationNameAr!,
                                    english:
                                        services[index].specializationNameEn!),
                                style: TextStyle(
                                    fontSize: 12.r,
                                    color: greyColor,
                                    fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Gap(8),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.isTablet ? 12.w : 0,
                                ),
                                child: Row(
                                  children: [
                                    if (Get.find<AppPreferences>()
                                                .getUserRole() ==
                                            "provider" &&
                                        Get.find<AppPreferences>()
                                                .getUserRoleId() ==
                                            services[index].providerId)
                                      Expanded(
                                        flex: 2,
                                        child: Visibility(
                                          visible: Get.find<AppPreferences>()
                                                  .getUserRole() ==
                                              "provider",
                                          child: InkWell(
                                            onTap: () {
                                              Get.toNamed(
                                                AppRoutes.editProviderService,
                                                arguments: {
                                                  "service": services[index],
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 28.h,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    customBorderRadius,
                                                border: Border.all(
                                                  color: primaryColor,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "Edit".tr,
                                                  style:
                                                      getRegularStyle(context)
                                                          .copyWith(
                                                    fontWeight: FontManager
                                                        .mediumFontWeight,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    Gap(8),
                                    Expanded(
                                        flex: context.isTablet ? 1 : 2,
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              AppRoutes.serviceDetails,
                                              arguments: {
                                                "id": services[index].id,
                                              },
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "View".tr,
                                                style: getRegularStyle(context)
                                                    .copyWith(
                                                  fontWeight: FontManager
                                                      .mediumFontWeight,
                                                  fontSize: 14.r,
                                                  color: primaryColor,
                                                ),
                                              ),
                                              Gap(4),
                                              Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: primaryColor,
                                                  size: 13.r)
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
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
