import 'package:b2b_partenership/controller/shop/shop_product_details_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:b2b_partenership/models/product_description_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:widget_zoom/widget_zoom.dart';

class ShopProductDetailsView extends StatelessWidget {
  const ShopProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopProductDetailsController>(
      init: ShopProductDetailsController(),
      builder: (ShopProductDetailsController controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
        ),
        bottomNavigationBar: Container(
          padding:
              EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h, top: 15),
          height: 0.11.sh,
          width: 1.sw,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(color: greyColor.withAlpha(100)),
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(8.r)),
                child: Icon(
                  CupertinoIcons.cart_fill,
                  color: greenColor,
                  size: context.isTablet ? 20.w : 25.sp,
                ),
              ),
              Gap(8.w),
              Expanded(
                child: CustomLoadingButton(
                  borderRadius: 10.r,
                  onPressed: () {
                    return controller.addToCart();
                  },
                  backgroundColor:
                      controller.product == null ? greyColor : primaryColor,
                  text: "Add To Cart".tr,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: CustomServerStatusWidget(
            statusRequest: controller.statusRequest,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translateDatabase(
                      arabic: controller.product?.titleAr ?? "",
                      english: controller.product?.titleEn ?? "",
                    ),
                    style: getSemiBoldStyle(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(20.h),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      WidgetZoom(
                        heroAnimationTag:
                            controller.product?.id.toString() ?? "hero",
                        zoomWidget: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: CachedNetworkImage(
                            imageUrl: controller.product?.image ?? "",
                            fit: BoxFit.cover,
                            height: context.isTablet ? 160.h : 120.h,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Container(
                        height: context.isTablet ? 160.h : 120.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: blackColor.withAlpha(170),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withAlpha(200),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          "-${controller.product?.discount ?? "0"}%",
                          style: context.isTablet
                              ? getRegularStyle(context).copyWith(
                                  color: whiteColor,
                                  fontWeight: FontManager.boldFontWeight,
                                )
                              : getLightStyle(context).copyWith(
                                  color: whiteColor,
                                  fontWeight: FontManager.boldFontWeight,
                                ),
                        ),
                      )
                    ],
                  ),
                  Gap(20.h),
                  Text(
                    "Training Sessions".tr,
                    style: getSemiBoldStyle(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(20.h),
                  ExpansionPanelList(
                    expandedHeaderPadding: EdgeInsets.only(bottom: 15),
                    elevation: 1,
                    materialGapSize: 20.h,
                    expandIconColor: blackColor,
                    expansionCallback: (int index, bool isExpanded) {
                      controller.callBackFun(index, isExpanded);
                    },
                    children: controller.descriptions
                        .map<ExpansionPanel>((ProductDescriptionModel item) {
                      return ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return Container(
                              decoration: BoxDecoration(
                                // border:
                                //     Border.all(color: greyColor.withAlpha(100)),
                                borderRadius: BorderRadius.circular(8.0),
                                color: isExpanded
                                    ? Colors.indigo.withAlpha(170)
                                    : null,
                                gradient: isExpanded
                                    ? LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Colors.indigo.withAlpha(60),
                                          Colors.indigo.withAlpha(50),
                                          Colors.indigo.withAlpha(40),
                                          Colors.indigo.withAlpha(30),
                                          Colors.indigo.withAlpha(20),
                                          Colors.indigo.withAlpha(10),
                                          Colors.transparent,
                                        ],
                                      )
                                    : null,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          translateDatabase(
                                              arabic: item.titleAr,
                                              english: item.titleEn),
                                          style:
                                              getMediumStyle(context).copyWith(
                                            color: blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          body: Padding(
                            padding: EdgeInsets.only(
                                bottom: 15.0, left: 20.w, right: 20.w),
                            child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => Gap(10),
                              itemCount: item.contents.length,
                              itemBuilder: (context, i) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Icon(
                                      Icons.check_circle,
                                      size: 17.r,
                                      color: greenColor,
                                    ),
                                  ),
                                  Gap(10.w),
                                  Expanded(
                                    child: Text(
                                      translateDatabase(
                                          arabic: item.contents[i].contentAr,
                                          english: item.contents[i].contentEn),
                                      style: getMediumStyle(context).copyWith(
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          isExpanded: item.isExpanded == 0 ? false : true);
                    }).toList(),
                  ),
                  Gap(30.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    child: Row(
                      children: [
                        Text(
                          "Training bag Price : ".tr,
                          style: getMediumStyle(context).copyWith(
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                          ),
                        ),
                        Gap(10.w),
                        if (controller.product?.discount != "0")
                          Text(
                            "${controller.product?.price ?? "0"}\$",
                            style: getRegularStyle(context).copyWith(
                              fontWeight: FontManager.lightFontWeight,
                              color: whiteColor.withAlpha(190),
                              decorationColor: whiteColor.withAlpha(190),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Gap(6.w),
                        Text(
                          controller.product?.discount != "0"
                              ? "${double.parse(controller.product?.price ?? "0") - (double.parse(controller.product?.discount ?? "0") / 100 * double.parse(controller.product?.price ?? "0"))}\$"
                              : "${controller.product?.price ?? "0"}\$",
                          style: getRegularStyle(context).copyWith(
                              fontWeight: FontManager.boldFontWeight,
                              color: Colors.amber),
                        ),
                      ],
                    ),

                    // Text(
                    //   "Training package data",
                    //   style: TextStyle(
                    //       fontSize: 15.sp,
                    //       fontWeight: FontWeight.bold,
                    //       color: whiteColor),
                    // ),
                  ),
                  Gap(20.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 250, 250, 249)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.report_gmailerrorred,
                              size: 24.r,
                            ),
                            Gap(10.w),
                            Text(
                              "About the training bag".tr,
                              style: getSemiBoldStyle(context).copyWith(
                                fontWeight: FontManager.semiBoldFontWeight,
                              ),
                            ),
                          ],
                        ),
                        Gap(10.h),
                        Text(
                          translateDatabase(
                                arabic: controller.product?.descriptionAr ?? "",
                                english:
                                    controller.product?.descriptionEn ?? "",
                              ) +
                              " ",
                          style: getMediumStyle(context).copyWith(
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 101, 101, 108),
                          ),
                          maxLines: 100,
                        ),
                      ],
                    ),
                  ),
                  Gap(20.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    child: Text(
                      "Terms and condition".tr,
                      style: getMediumStyle(context).copyWith(
                          fontWeight: FontWeight.bold, color: whiteColor),
                    ),
                  ),
                  Gap(20.h),
                  Text(
                    translateDatabase(
                      arabic: controller.product?.termsAndConditionsAr ?? "",
                      english: controller.product?.termsAndConditionsEn ?? "",
                    ),
                    style: getMediumStyle(context).copyWith(
                      fontWeight: FontWeight.normal,
                      color: blackColor,
                    ),
                    maxLines: 100,
                  ),
                  Gap(40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
