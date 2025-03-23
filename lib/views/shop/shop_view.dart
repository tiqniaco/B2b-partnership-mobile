import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/shop/shop_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:b2b_partenership/widgets/shop/shop_item_product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
                        controller.getShopProducts(firstTime: true);
                      }
                    },
                  ),
                ),
                Gap(1.w),
                IconButton(
                  onPressed: () {
                    controller.getShopProducts(firstTime: true);
                  },
                  icon: Icon(
                    CupertinoIcons.search,
                    size: context.isTablet ? 13.w : 18.w,
                    color: blackColor,
                  ),
                ),
              ],
            ),
            backgroundColor: whiteColor,
            actions: [
              Container(
                margin: EdgeInsetsDirectional.only(end: 8.w),
                child: IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.shopCart);
                  },
                  icon: Icon(
                    CupertinoIcons.shopping_cart,
                    color: blackColor,
                    size: context.isTablet ? 16.w : 24.w,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(end: 8.w),
                child: IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.shopOrders);
                  },
                  icon: SvgPicture.asset(
                    'assets/svgs/bag2.svg',
                    width: context.isTablet ? 16.w : 24.w,
                  ),
                ),
              ),
            ],
          ),
          body: Row(
            children: [
              if (controller.showCategories)
                SizedBox(
                  width: 0.21.sw,
                  height: 1.sh,
                  child: CustomServerStatusWidget(
                    statusRequest: controller.categoriesStatus,
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 4.w,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(8.r),
                          splashColor: primaryColor.withAlpha(10),
                          onTap: () {
                            controller.onTapCategory(index);
                          },
                          child: SizedBox(
                            height: 70.h,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 18.r,
                                  backgroundColor: primaryColor.withAlpha(10),
                                  child: CustomNetworkImage(
                                    imageUrl:
                                        controller.shopCategories[index].image,
                                    // shape: BoxShape.circle,
                                  ),
                                ),
                                Gap(5.h),
                                Text(
                                  translateDatabase(
                                    arabic:
                                        controller.shopCategories[index].nameAr,
                                    english:
                                        controller.shopCategories[index].nameEn,
                                  ),
                                  style: getLightStyle(context).copyWith(
                                    fontWeight: controller.selectedCategory ==
                                            controller.shopCategories[index]
                                        ? FontManager.boldFontWeight
                                        : FontManager.regularFontWeight,
                                    color: controller.selectedCategory ==
                                            controller.shopCategories[index]
                                        ? primaryColor
                                        : greyColor,
                                    fontSize: context.isTablet ? 7.sp : 9.5.sp,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Gap(10.h),
                      itemCount: controller.shopCategories.length,
                    ),
                  ),
                ),
              Stack(
                children: [
                  PositionedDirectional(
                    start: 0,
                    top: 0,
                    bottom: 0,
                    end: 0,
                    child: VerticalDivider(
                      thickness: 2.w,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      onTap: () {
                        controller.changeShowCategories();
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        color: primaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Icon(
                            controller.showCategories
                                ? Icons.arrow_back_ios_new
                                : Icons.arrow_forward_ios_outlined,
                            color: whiteColor,
                            size: context.isTablet ? 12.sp : 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: CustomServerStatusWidget(
                  statusRequest: controller.productsStatus,
                  child: GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          context.isTablet && !controller.showCategories
                              ? 3
                              : 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 15.h,
                      childAspectRatio: 1 / 1.2,
                    ),
                    itemCount: controller.shopProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.shopProducts[index];
                      return ShopProductItemWidget(
                        product: product,
                        showCategories: controller.showCategories,
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.shopProductDetails,
                            arguments: {
                              "product": product,
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
