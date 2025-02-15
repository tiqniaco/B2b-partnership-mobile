import 'package:b2b_partenership/controller/shop/shop_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
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
            titleSpacing: 0,
            title: Row(
              children: [
                SizedBox(
                  width: 0.5.sw,
                  child: TextFormField(
                    controller: controller.searchController,
                    style: getRegularStyle,
                    decoration: InputDecoration(
                      hintText: 'Search...'.tr,
                      hintStyle: getRegularStyle,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greyColor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        controller.getShopProducts(firstTime: true);
                      }
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.getShopProducts(firstTime: true);
                  },
                  icon: Icon(
                    CupertinoIcons.search,
                    color: blackColor,
                  ),
                ),
              ],
            ),
            backgroundColor: whiteColor,
            // bottom: PreferredSize(
            //   preferredSize: Size.fromHeight(1.h),
            //   child: Container(
            //     height: 1.h,
            //     color: dividerColor,
            //   ),
            // ),
            actions: [
              Container(
                margin: EdgeInsetsDirectional.only(end: 8.w),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.shopping_cart,
                    color: blackColor,
                    size: 24.sp,
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
                                  style: getLightStyle.copyWith(
                                    fontWeight: controller.selectedCategory ==
                                            controller.shopCategories[index]
                                        ? FontManager.boldFontWeight
                                        : FontManager.regularFontWeight,
                                    color: controller.selectedCategory ==
                                            controller.shopCategories[index]
                                        ? primaryColor
                                        : greyColor,
                                    fontSize: 9.5.sp,
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
                            size: 16.sp,
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
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 15.h,
                      childAspectRatio: 1 / 1.2,
                    ),
                    itemCount: controller.shopProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.shopProducts[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: borderColor,
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          clipBehavior: Clip.hardEdge,
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: FractionallySizedBox(
                                  widthFactor: 1.2,
                                  child: Stack(
                                    children: [
                                      CustomNetworkImage(
                                        imageUrl: product.image,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                      if (product.discount != "0")
                                        PositionedDirectional(
                                          top: 8.h,
                                          end: 8.w,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 2.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                            child: Text(
                                              "-${product.discount}%",
                                              style: getBoldStyle.copyWith(
                                                fontSize: 10.sp,
                                                color: whiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(8.h),
                              Text(
                                translateDatabase(
                                  arabic: product.titleAr,
                                  english: product.titleEn,
                                ),
                                style: getLightStyle.copyWith(
                                  fontWeight: FontManager.mediumFontWeight,
                                  fontSize:
                                      controller.showCategories ? 11.sp : 13.sp,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  if (product.discount != "0")
                                    Text(
                                      "${product.price}\$",
                                      style: getLightStyle.copyWith(
                                        fontSize: controller.showCategories
                                            ? 11.sp
                                            : 13.sp,
                                        color: blackColor.withAlpha(150),
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  Gap(5.w),
                                  Text(
                                    product.discount != "0"
                                        ? "${double.parse(product.price) - (double.parse(product.discount) / 100 * double.parse(product.price))}\$"
                                        : "${product.price}\$",
                                    style: getLightStyle.copyWith(
                                        fontWeight:
                                            FontManager.semiBoldFontWeight,
                                        fontSize: controller.showCategories
                                            ? 11.sp
                                            : 13.sp,
                                        color: primaryColor),
                                  ),
                                ],
                              ),
                              Gap(8.h),
                            ],
                          ),
                        ),
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
