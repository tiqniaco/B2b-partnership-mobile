import 'dart:developer';

import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/shop/shop_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget_sliver.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/shop/all_felids_widget.dart';
import 'package:b2b_partenership/widgets/shop/category_item.dart';
import 'package:b2b_partenership/widgets/shop/shop_item_product_row_widget.dart';
import 'package:b2b_partenership/widgets/shop/shop_item_product_stack_widget.dart';
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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.searchController,
                            style: getRegularStyle(context),
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                onPressed: () {
                                  if (controller
                                      .searchController.text.isNotEmpty) {
                                    controller.getMostProducts(isSearch: true);
                                  } else {
                                    controller.getMostProducts();
                                  }
                                },
                                icon: Icon(
                                  CupertinoIcons.search,
                                  size: context.isTablet ? 13.w : 18.w,
                                  color: primaryColor,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: context.isTablet ? 10.h : 0,
                                horizontal: context.isTablet ? 10.w : 20.w,
                              ),
                              hintText: 'Search'.tr,
                              hintStyle: getBoldStyle(context).copyWith(
                                  fontSize: 18.r, color: primaryColor),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: greyColor),
                                borderRadius: 
                                BorderRadius.only(
                                  topRight: Radius.circular(10.r),
                                  bottomLeft: Radius.circular(10.r),
                                ),
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {
                                controller.getMostProducts(isSearch: true);
                              } else {
                                controller.getMostProducts();
                              }
                            },
                          ),
                        ),
                        Gap(24),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.shopCart);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 14),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.r),
                                  bottomLeft: Radius.circular(10.r)),
                            ),
                            child: Icon(
                              Icons.shopping_cart,
                              color: whiteColor,
                              size: 20.r,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 125.h,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Gap(10),
                      itemCount: controller.shopCategories.length + 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          index != controller.shopCategories.length
                              ? CategoryItem(
                                  model: controller.shopCategories[index],
                                  index,
                                )
                              : AllFelidsWidget(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Text(
                    "Best Selling Bags".tr,
                    style: getMediumStyle(context).copyWith(
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                      fontSize: 18.r,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Gap(20),
                ),
                CustomServerStatusSliverWidget(
                  statusRequest: controller.productsStatus,
                  child: SliverList.separated(
                    separatorBuilder: (context, index) => Gap(20.h),
                    itemCount: controller.shopMostProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.shopMostProducts[index];
                      return ShopItemProductRowWidget(
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
                SliverToBoxAdapter(
                  child: Gap(24),
                ),
                SliverToBoxAdapter(
                  child: Text(
                    "Recommended Bags".tr,
                    style: getMediumStyle(context).copyWith(
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                      fontSize: 18.r,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Gap(20),
                ),
                CustomServerStatusSliverWidget(
                  statusRequest: controller.recommendedProductsStatus,
                  child: SliverList.separated(
                    separatorBuilder: (context, index) => Gap(20.h),
                    itemCount: controller.shopRecommendedProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.shopRecommendedProducts[index];
                      return ShopItemProductStackWidget(
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
              ],
            ),
          ),
        );
      },
    );
  }
}
