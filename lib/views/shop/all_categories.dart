import 'package:b2b_partenership/controller/shop/all_categoties_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
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
        backgroundColor: whiteColor,
        title: Text("Categories List"),
      ),
      body: GetBuilder<AllCategoriesController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView.separated(
            separatorBuilder: (context, index) => Gap(20),
            itemCount: controller.shopCategories.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                // controller.onTapCategory(index - 1);
              },
              child: SizedBox(
                //width: 100.w,
                height: 130.h,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
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
                          borderRadius: BorderRadius.circular(5.r),
                          color: blackColor.withAlpha(140)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.mediation_outlined,
                            color: Colors.white,
                            size: 25.sp,
                          ),
                          Gap(10.h),
                          Spacer(),
                          Text(
                            translateDatabase(
                              arabic: controller.shopCategories[index].nameAr,
                              english: controller.shopCategories[index].nameEn,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 17.sp,
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
