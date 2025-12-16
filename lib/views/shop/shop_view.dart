import 'dart:developer';

import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/shop/shop_controller.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/global/widgets/custom_error_widget.dart';
import 'package:b2b_partenership/core/global/widgets/custom_no_connection_widget.dart';
import 'package:b2b_partenership/core/global/widgets/global_sliver_server_status_widget.dart';
import 'package:b2b_partenership/core/global/widgets/place_holder.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/home/work_category_loading.dart';
import 'package:b2b_partenership/widgets/shop/all_felids_widget.dart';
import 'package:b2b_partenership/widgets/shop/category_item.dart';
import 'package:b2b_partenership/widgets/shop/product_row_loading_widget.dart';
import 'package:b2b_partenership/widgets/shop/product_stack_loading_sliver_list.dart';
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
            child: controller.categoriesStatus == StatusRequest.noConnection
                ? CustomNoConnectionWidget(
                    onTap: () {
                      controller.getShopCategories();
                      controller.getMostProducts();
                      controller.recommendedProducts();
                    },
                  )
                : CustomScrollView(
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
                                          controller.getMostProducts(
                                              isSearch: true);
                                        } else {
                                          controller.getMostProducts();
                                        }
                                      },
                                      icon: Icon(
                                        CupertinoIcons.search,
                                        size: context.isTablet ? 13.w : 18.w,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: context.isTablet ? 10.h : 12,
                                      horizontal:
                                          context.isTablet ? 10.w : 20.w,
                                    ),
                                    hintText: 'Search'.tr,
                                    hintStyle: TextStyle(
                                      fontSize: 16.r,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: greyColor),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.r),
                                        bottomLeft: Radius.circular(10.r),
                                      ),
                                    ),
                                  ),
                                  onFieldSubmitted: (value) {
                                    if (value.isNotEmpty) {
                                      controller.getMostProducts(
                                          isSearch: true);
                                    } else {
                                      controller.getMostProducts();
                                    }
                                  },
                                ),
                              ),
                              Gap(16),
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
                          height: 135.h,
                          child: controller.categoriesStatus ==
                                  StatusRequest.loading
                              ? ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  separatorBuilder: (context, index) => Gap(6),
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: WorkCategoryShimmer(),
                                  ),
                                )
                              : ListView.separated(
                                  separatorBuilder: (context, index) => Gap(10),
                                  itemCount:
                                      controller.shopCategories.length + 1,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      index != controller.shopCategories.length
                                          ? CategoryItem(
                                              model: controller
                                                  .shopCategories[index],
                                              index,
                                            )
                                          : AllFelidsWidget(),
                                ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Gap(10),
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
                      GlobalSliverServerStatusWidget(
                        statusRequest: controller.productsStatus,
                        noDataChild: SliverToBoxAdapter(
                          child: PlaceHolderWidget(
                            icon: Image.asset("assets/images/no_orders.png"),
                            title: 'No Bags Now'.tr,
                            subTitle: 'Try again later'.tr,
                          ),
                        ),
                        errorChild:
                            SliverToBoxAdapter(child: CustomErrorWidget()),
                        noConnectionChild: SliverToBoxAdapter(
                          child: CustomNoConnectionWidget(
                            onTap: () {
                              controller.getMostProducts();
                            },
                          ),
                        ),
                        loadingChild: ProductRowLoadingWidget(),
                        successChild: SliverList.separated(
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
                      GlobalSliverServerStatusWidget(
                        statusRequest: controller.recommendedProductsStatus,
                        noDataChild: SliverToBoxAdapter(
                          child: PlaceHolderWidget(
                            icon: Image.asset("assets/images/no_orders.png"),
                            title: 'No Bags Now'.tr,
                            subTitle: 'Try again later'.tr,
                          ),
                        ),
                        errorChild:
                            SliverToBoxAdapter(child: CustomErrorWidget()),
                        noConnectionChild: SliverToBoxAdapter(
                          child: CustomNoConnectionWidget(
                            onTap: () {
                              controller.recommendedProducts();
                            },
                          ),
                        ),
                        loadingChild: ProductStackLoadingSliverList(),
                        successChild: SliverList.separated(
                          separatorBuilder: (context, index) => Gap(20.h),
                          itemCount: controller.shopRecommendedProducts.length,
                          itemBuilder: (context, index) {
                            final product =
                                controller.shopRecommendedProducts[index];
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
                      SliverToBoxAdapter(
                        child: Gap(80),
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }
}
