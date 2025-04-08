import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/see_all/see_all_category_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SeeAllCategories extends StatelessWidget {
  const SeeAllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SeeAllCategoryController());
    return GetBuilder<SeeAllCategoryController>(
      builder: (controller) => Scaffold(
          appBar: AppBar(
            toolbarHeight: context.isTablet ? 45.h : null,
            backgroundColor: whiteColor,
            title: Text(
              "All Categories",
              style: getMediumStyle(context),
            ),
          ),
          body: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.isTablet ? 3 : 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 15),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.providersInCategory,
                          arguments: {"model": controller.categories[index]});
                    },
                    child: Container(
                      width: 100.h,
                      height: 120.h,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.withAlpha(80))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: pageColor.withAlpha(60)),
                            child: CachedNetworkImage(
                              imageUrl: controller.categories[index].image!,
                              height: 32.h,
                            ),
                          ),
                          Gap(8.h),
                          Text(
                            translateDatabase(
                                arabic: controller.categories[index].nameAr!,
                                english: controller.categories[index].nameEn!),
                            textAlign: TextAlign.center,
                            style: context.isTablet
                                ? getRegularStyle(context).copyWith(
                                    fontWeight: FontWeight.w400,
                                  )
                                : getLightStyle(context).copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ))),
    );
  }
}
