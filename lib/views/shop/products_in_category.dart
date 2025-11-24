import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/shop/products_in_category_controller.dart';
import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/shop/shop_item_product_stack_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductsInCategory extends StatelessWidget {
  const ProductsInCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsInCategoryController>(
      init: ProductsInCategoryController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          //backgroundColor: whiteColor,
          title: Text(
            translateDatabase(
              arabic: controller.model.nameAr,
              english: controller.model.nameEn,
            ),
            textDirection: containsArabic(controller.model.nameAr)
                ? TextDirection.rtl
                : TextDirection.ltr,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: 40.h,
                    child: TextFormField(
                      controller: controller.searchController,
                      style: getRegularStyle(context),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.getProducts(firstTime: true);
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
                        filled: true,
                        fillColor: greyColor.withAlpha(30),
                        hintStyle: getRegularStyle(context),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: greyColor.withAlpha(30)),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          controller.getProducts(firstTime: true);
                        }
                      },
                    ),
                  ),
                ),
                Gap(10.h),
                Divider(
                  color: greyColor.withAlpha(50),
                  //thickness: 1,
                ),
                Expanded(
                  child: CustomServerStatusWidget(
                    statusRequest: controller.productsStatus,
                    child: ListView.separated(
                      controller: controller.productsScrollController,
                      separatorBuilder: (context, index) => Gap(20.h),
                      padding: EdgeInsets.all(10),
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        return ShopItemProductStackWidget(
                          product: product,
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.shopProductDetails,
                              arguments: {
                                "product": product,
                                "productId": product.id.toString(),
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
          ),
        ),
      ),
    );
  }
}
