import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/shop/shop_cart_controller.dart';
import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/functions/responsive_font.dart';
import 'package:b2b_partenership/core/global/widgets/custom_error_widget.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/global/widgets/custom_no_connection_widget.dart';
import 'package:b2b_partenership/core/global/widgets/global_server_status_widget.dart';
import 'package:b2b_partenership/core/global/widgets/place_holder.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/widgets/shop/about_bag_widget.dart';
import 'package:b2b_partenership/widgets/shop/price_widget.dart';
import 'package:b2b_partenership/widgets/shop/shop_product_details_loading.dart';
import 'package:b2b_partenership/widgets/shop/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:b2b_partenership/controller/shop/shop_product_details_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';

class ShopProductDetailsView extends StatelessWidget {
  const ShopProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ShopProductDetailsController>(
        init: ShopProductDetailsController(),
        builder: (controller) => GlobalServerStatusWidget(
          statusRequest: controller.statusRequest,
          errorChild: CustomErrorWidget(),
          noConnectionChild: CustomNoConnectionWidget(
            onTap: () => controller.getProductDetails(),
          ),
          noDataChild: PlaceHolderWidget(
            icon: Image.asset("assets/images/no_order.png"),
            title: "No services founded now",
            subTitle: "try again later",
          ),
          loadingChild: ShopProductDetailsLoading(),
          successChild: Scaffold(
            appBar: AppBar(
              toolbarHeight: context.isTablet ? 45.h : null,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Bag Details".tr,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.r,
                          fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () => Get.toNamed(AppRoutes.shopCart),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: customBorderRadius),
                      child: Icon(
                        Icons.shopping_cart,
                        color: whiteColor,
                        size: 20.r,
                      ),
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              height: 60.h,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: controller.downloadDemo,
                      icon: Icon(Icons.download, color: primaryColor, size: 18),
                      label: Text("Demo".tr,
                          style: TextStyle(
                              fontSize: 11.rf(),
                              color: primaryColor,
                              fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        //padding: EdgeInsets.symmetric(vertical: 4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        side: BorderSide(color: primaryColor, width: 1.2),
                        fixedSize: Size(120.w, 57.h),
                      ),
                    ),
                  ),
                  Gap(8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: controller.downloadDemo,
                      icon: Badge(
                        padding: EdgeInsets.all(0),
                        label: Text(
                          Get.put(
                            ShopCartController()..getCart(),
                          ).carts.length.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 8.r),
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: primaryColor,
                          size: 20.r,
                        ),
                      ),
                      label: Text("Add to Cart".tr,
                          style: TextStyle(
                              fontSize: 11.rf(),
                              color: primaryColor,
                              fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: primaryColor.withAlpha(50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        side: BorderSide(
                            color: primaryColor.withAlpha(30), width: 1.2),
                        fixedSize: Size(120.w, 57.h),
                      ),
                    ),
                  ),

                  // Expanded(
                  //   child: Container(
                  //       padding: EdgeInsets.symmetric(horizontal: 12),
                  //       decoration: BoxDecoration(
                  //           color: primaryColor.withAlpha(50),
                  //           borderRadius: BorderRadius.circular(8)),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Gap(10),
                  //           Badge(
                  //             padding: EdgeInsets.all(0),
                  //             label: Text(
                  //               Get.put(
                  //                 ShopCartController()..getCart(),
                  //               ).carts.length.toString(),
                  //               style: TextStyle(
                  //                   color: Colors.white, fontSize: 8.r),
                  //             ),
                  //             child: Icon(
                  //               Icons.shopping_cart,
                  //               color: primaryColor,
                  //               size: 20.r,
                  //             ),
                  //           ),
                  //           Gap(8),
                  //           Expanded(
                  //             child: CustomLoadingButton(
                  //               height: 55.h,
                  //               textColor: primaryColor,
                  //               text: "Add to Cart".tr,
                  //               fontSize: 11.r,
                  //               onPressed: controller.addToCart,
                  //               backgroundColor: transparentColor,
                  //               borderRadius: 8,
                  //             ),
                  //           ),
                  //         ],
                  //       )),
                  // ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 8),
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: primaryColor.withAlpha(25),
                                ),
                                child: CustomNetworkImage(
                                  imageUrl: controller.product?.image ?? "",
                                  height: context.isTablet ? 200.h : 180.h,
                                  borderRadius: 8,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                    ),
                                    color: primaryColor,
                                  ),
                                  child: Text(
                                    "- ${controller.product?.discount ?? "0"} %",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.rf()),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Gap(8),
                        Text(
                          controller.product?.titleEn ?? "",
                          textDirection:
                              containsArabic(controller.product?.titleEn ?? "")
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                          style: TextStyle(
                              height: 1.2,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.rf(max: 15)),
                        ),
                        Gap(8),
                        priceRow(
                          controller.product?.price,
                          controller.product?.discount,
                          color: blackColor,
                          priceFontSize: 16,
                          offPrice: 14,
                        ),
                        Gap(20),
                        _buildTabs(controller, context),
                        Gap(20),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: IndexedStack(
                      index: controller.selectedIndex,
                      children: [
                        AboutBagWidget(),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: lightPrimaryColor.withAlpha(140),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              ...controller.descriptions
                                  .map((e) => _sessionItem(context, e)),
                            ],
                          ),
                        ),
                        TermsAndConditions(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(
      ShopProductDetailsController controller, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTab("About Bag", 0, context, controller),
        Gap(8),
        _buildTab("Sessions", 1, context, controller),
        Gap(8),
        _buildTab("Policy", 2, context, controller),
      ],
    );
  }

  Widget _buildTab(String title, int index, BuildContext context,
      ShopProductDetailsController controller) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.onTabTapped(index),
        child: Container(
          height: 35.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
              borderRadius: customBorderRadius,
              color: controller.selectedIndex == index
                  ? primaryColor
                  : Colors.transparent,
              border: Border.all(color: greyColor)),
          child: Text(title.tr,
              textAlign: TextAlign.center,
              style: getMediumStyle(Get.context!).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 11.rf(),
                color:
                    controller.selectedIndex == index ? whiteColor : blackColor,
              )),
        ),
      ),
    );
  }

  Widget _sessionItem(BuildContext context, dynamic e) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        translateDatabase(arabic: e.titleAr, english: e.titleEn),
        style: TextStyle(fontSize: 14.rf(), fontWeight: FontWeight.w500),
      ),
      children: e.contents.map<Widget>((item) {
        return ListTile(
          contentPadding: EdgeInsets.only(left: 0, right: 0),
          horizontalTitleGap: 10,
          dense: true,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: primaryColor, size: 15.r),
            ],
          ),
          title: Text(
            translateDatabase(arabic: item.contentAr, english: item.contentEn),
            style: TextStyle(fontSize: 12.rf()),
          ),
        );
      }).toList(),
    );
  }
}
