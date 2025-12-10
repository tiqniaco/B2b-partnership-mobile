import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/shop/shop_cart_controller.dart';
import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/widgets/shop/about_bag_widget.dart';
import 'package:b2b_partenership/widgets/shop/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:b2b_partenership/controller/shop/shop_product_details_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';

class ShopProductDetailsView extends StatelessWidget {
  const ShopProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopProductDetailsController>(
      init: ShopProductDetailsController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          toolbarHeight: context.isTablet ? 45.h : null,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Bag Details".tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.r,
                      fontWeight: FontWeight.w500)),
              InkWell(
                onTap: () => Get.toNamed(AppRoutes.shopCart),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                      color: primaryColor, borderRadius: customBorderRadius),
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
                          fontSize: 13.r,
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
                child: Container(
                    decoration: BoxDecoration(
                        color: primaryColor.withAlpha(70),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Badge(
                          padding: EdgeInsets.all(0),
                          label: Text(
                            Get.put(
                              ShopCartController()..getCart(),
                            ).carts.length.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 8.r),
                          ),
                          child: Icon(
                            Icons.shopping_cart,
                            color: primaryColor,
                            size: 20.r,
                          ),
                        ),
                        Gap(8),
                        SizedBox(
                          width: 92,
                          child: CustomLoadingButton(
                            height: 55.h,
                            textColor: primaryColor,
                            text: "Add to Cart".tr,
                            fontSize: 13.r,
                            onPressed: controller.addToCart,
                            backgroundColor: transparentColor,
                            borderRadius: 8,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: CustomServerStatusWidget(
                  statusRequest: controller.statusRequest,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: primaryColor.withAlpha(25),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: controller.product?.image ?? "",
                                  height: 180.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
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
                                      fontSize: 16.r),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Directionality(
                        textDirection:
                            containsArabic(controller.product?.titleEn ?? "")
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                        child: Text(
                          controller.product?.titleEn ?? "",
                          style: TextStyle(
                              height: 1.2,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.r),
                        ),
                      ),
                      Gap(8),
                      _priceRow(controller),
                      Gap(20),
                      _buildTabs(controller, context),
                      Gap(20),
                    ],
                  ),
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
        _buildTab("Terms & Conditions", 2, context, controller),
      ],
    );
  }

  Widget _buildTab(String title, int index, BuildContext context,
      ShopProductDetailsController controller) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.onTabTapped(index),
        child: Container(
          height: 45.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
              borderRadius: customBorderRadius,
              color: controller.selectedIndex == index
                  ? primaryColor
                  : Colors.transparent,
              border: Border.all(color: primaryColor)),
          child: Text(title.tr,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: getMediumStyle(Get.context!).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12.r,
                color: controller.selectedIndex == index
                    ? whiteColor
                    : primaryColor,
              )),
        ),
      ),
    );
  }

  Widget _priceRow(ShopProductDetailsController controller) {
    final double price = double.tryParse(controller.product?.price ?? "0") ?? 0;
    final double discount =
        double.tryParse(controller.product?.discount ?? "0") ?? 0;
    final double finalPrice =
        discount > 0 ? price - (discount / 100 * price) : price;

    return Row(
      children: [
        Text("\ر.س ${finalPrice.toStringAsFixed(2)}",
            style: TextStyle(
                fontSize: 16.r,
                fontWeight: FontWeight.bold,
                color: primaryColor)),
        Gap(8),
        if (discount > 0)
          Text("\ر.س ${price.toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 14.r,
                color: blackColor,
                decoration: TextDecoration.lineThrough,
              )),
      ],
    );
  }

  Widget _sessionItem(BuildContext context, dynamic e) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        translateDatabase(arabic: e.titleAr, english: e.titleEn),
        style: TextStyle(fontSize: 16.r, fontWeight: FontWeight.w500),
      ),
      children: e.contents.map<Widget>((item) {
        return ListTile(
          contentPadding: EdgeInsets.only(left: 0, right: 0),
          horizontalTitleGap: 10,
          dense: true,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: primaryColor, size: 18.r),
            ],
          ),
          title: Text(
            translateDatabase(arabic: item.contentAr, english: item.contentEn),
            style: TextStyle(fontSize: 15.r),
          ),
        );
      }).toList(),
    );
  }
}
