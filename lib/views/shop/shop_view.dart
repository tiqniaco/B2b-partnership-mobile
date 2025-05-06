import 'dart:developer';

import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/shop/shop_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/shop/shop_item_product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
      init: ShopController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 5.w,
            toolbarHeight: context.isTablet ? 50.h : null,
            title: Row(
              children: [
                SizedBox(
                  width: context.isTablet ? 0.4.sw : 0.5.sw,
                  child: TextFormField(
                    controller: controller.searchController,
                    style: getRegularStyle(context),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (controller.searchController.text.isNotEmpty) {
                            controller.getShopProducts(isSearch: true);
                          } else {
                            controller.getShopProducts();
                          }
                        },
                        icon: Icon(
                          CupertinoIcons.search,
                          size: context.isTablet ? 13.w : 18.w,
                          color: blackColor,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: context.isTablet ? 10.h : 0,
                        horizontal: context.isTablet ? 10.w : 20.w,
                      ),
                      hintText: 'Search...'.tr,
                      hintStyle: getRegularStyle(context),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greyColor),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        controller.getShopProducts(isSearch: true);
                      } else {
                        controller.getShopProducts();
                      }
                    },
                  ),
                ),
              ],
            ),
            backgroundColor: whiteColor,
            actions: [
              Container(
                decoration:
                    BoxDecoration(color: greenColor, shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.shopCart);
                  },
                  icon: Icon(
                    CupertinoIcons.cart_fill,
                    color: whiteColor,
                    size: context.isTablet ? 16.w : 17.sp,
                  ),
                ),
              ),
              Gap(10.w),
            ],
          ),
          floatingActionButton: InkWell(
            onTap: () {
              controller.launchURL();
            },
            child: Material(
              borderRadius: BorderRadius.circular(70),
              elevation: 0.3,
              child: CircleAvatar(
                backgroundColor: whiteColor,
                radius: 27.r,
                backgroundImage: AssetImage("assets/images/whats.png"),
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 125.h,
                child: CustomServerStatusWidget(
                  statusRequest: controller.categoriesStatus,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return SizedBox(
                          width: 140.w,
                          height: 100.h,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: Image.asset(
                                  "assets/images/rr.png",
                                  fit: BoxFit.fitHeight,
                                  width: 140.w,
                                  height: 110.h,
                                ),
                              ),
                              Container(
                                width: 140.w,
                                height: 110.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    color: blackColor.withAlpha(50)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 20.0,
                                    right: 20.0,
                                    bottom: 10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.mediation_outlined,
                                      color: Colors.white,
                                      size: 20.r,
                                    ),
                                    Gap(8.h),
                                    Text(
                                      "All fields".tr,
                                      style: getMediumStyle(context).copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor),
                                    ),
                                    Gap(8.h),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.allCategories,
                                            arguments: {
                                              "categories":
                                                  controller.shopCategories
                                            });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: whiteColor,
                                        ),
                                        child: Text(
                                          "Show All".tr,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.teal),
                                        ),
                                      ),
                                    )
                                 
                                 
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return InkWell(
                          onTap: () {
                            controller.onTapCategory(index - 1);
                          },
                          child: SizedBox(
                            width: 100.w,
                            height: 110.h,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.r),
                                  child: CustomNetworkImage(
                                    imageUrl: controller
                                        .shopCategories[index - 1].image,
                                    width: 100.w,
                                    height: 110.h,
                                  ),
                                ),
                                Container(
                                  width: 100.w,
                                  height: 110.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: blackColor.withAlpha(140)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.mediation_outlined,
                                        color: Colors.white,
                                        size: 20.r,
                                      ),
                                      Gap(10.h),
                                      Spacer(),
                                      Text(
                                        translateDatabase(
                                          arabic: controller
                                              .shopCategories[index - 1].nameAr,
                                          english: controller
                                              .shopCategories[index - 1].nameEn,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: getRegularStyle(context)
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: whiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    separatorBuilder: (context, index) => Gap(5.w),
                    itemCount: controller.shopCategories.length + 1,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Text(
                  "Best Selling Bags".tr,
                  style: getMediumStyle(context).copyWith(
                    fontWeight: FontWeight.w500,
                    color: blackColor,
                  ),
                ),
              ),
              Expanded(
                child: CustomServerStatusWidget(
                  statusRequest: controller.productsStatus,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Gap(20.h),
                    padding: EdgeInsets.all(10),
                    itemCount: controller.shopProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.shopProducts[index];
                      return ShopProductItemWidget(
                        product: product,
                        onTap: () {
                          log(product.id, name: "id");
                          Get.toNamed(
                            AppRoutes.shopProductDetails,
                            arguments: {
                              "product": product,
                              "productId": product.id,
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Gap(40)
            ],
          ),
        );
      },
    );
  }
}
