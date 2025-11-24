import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/shop/all_categories_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AllCategoriesController());
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: whiteColor,
        title: Text(
          "Categories List".tr,
          style: getMediumStyle(context).copyWith(
            fontWeight: FontWeight.bold,
            color: blackColor,
          ),
        ),
      ),
      body: GetBuilder<AllCategoriesController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 20,
          ),
          child: ListView.separated(
            separatorBuilder: (context, index) => Gap(20),
            itemCount: controller.shopCategories.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.productsInCategory,
                    arguments: {"model": controller.shopCategories[index]});
              },
              child: SizedBox(
                height: 130.h,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r),
                      ),
                      child: CustomNetworkImage(
                        imageUrl: controller.shopCategories[index].image,
                        width: double.infinity,
                        height: 130.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      //,
                      height: 130.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            bottomLeft: Radius.circular(10.r),
                          ),
                          //color: blackColor.withAlpha(80),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black,
                              Colors.black.withAlpha(200),

                              Colors.black.withAlpha(150),
                              Colors.black.withAlpha(150),
                              // Colors.black,
                              Colors.transparent,
                              // Colors.black.withAlpha(150),
                              Colors.transparent,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.transparent,
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Spacer(),
                          Text(
                            translateDatabase(
                              arabic: controller.shopCategories[index].nameAr,
                              english: controller.shopCategories[index].nameEn,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: getSemiBoldStyle(context).copyWith(
                                fontSize: 20.r,
                                fontWeight: FontWeight.bold,
                                color: whiteColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
