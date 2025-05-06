// import 'package:b2b_partenership/app_routes.dart';
// import 'package:b2b_partenership/controller/shop/shop_product_details_controller.dart';
// import 'package:b2b_partenership/core/functions/translate_database.dart';
// import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
// import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
// import 'package:b2b_partenership/core/theme/app_color.dart';
// import 'package:b2b_partenership/core/theme/text_style.dart';
// import 'package:b2b_partenership/core/utils/font_manager.dart';
// import 'package:b2b_partenership/models/product_description_model.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:widget_zoom/widget_zoom.dart';
//
// class ShopProductDetailsView extends StatelessWidget {
//   const ShopProductDetailsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ShopProductDetailsController>(
//       init: ShopProductDetailsController(),
//       builder: (ShopProductDetailsController controller) => Scaffold(
//         appBar: AppBar(
//           backgroundColor: whiteColor,
//         ),
//         bottomNavigationBar: Container(
//           padding:
//               EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h, top: 15),
//           height: 0.11.sh,
//           width: 1.sw,
//           child: Row(
//             children: [
//               InkWell(
//                 onTap: () {
//                   Get.toNamed(AppRoutes.shopCart);
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                       border: Border.all(color: greyColor.withAlpha(100)),
//                       color: whiteColor,
//                       borderRadius: BorderRadius.circular(8.r)),
//                   child: Icon(
//                     CupertinoIcons.cart_fill,
//                     color: greenColor,
//                     size: context.isTablet ? 20.w : 25.sp,
//                   ),
//                 ),
//               ),
//               Gap(8.w),
//               SizedBox(
//                 width: 0.26.sw,
//                 height: 0.06.sh,
//                 child: MaterialButton(
//                   onPressed: () {
//                     controller.downloadDemo();
//                   },
//                   color: whiteColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.r),
//                     side: BorderSide(
//                       color: greyColor.withAlpha(100),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         FontAwesomeIcons.download,
//                         color: greenColor,
//                         size: 20.r,
//                       ),
//                       Gap(5.w),
//                       Expanded(
//                         child: Text(
//                           "Demo".tr,
//                           style: getRegularStyle(context).copyWith(
//                             fontWeight: FontManager.semiBoldFontWeight,
//                           ),
//                           maxLines: 2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Gap(8.w),
//               Expanded(
//                 flex: 2,
//                 child: CustomLoadingButton(
//                   borderRadius: 10.r,
//                   onPressed: () {
//                     return controller.addToCart();
//                   },
//                   backgroundColor:
//                       controller.product == null ? greyColor : primaryColor,
//                   text: "Add To Cart".tr,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: SafeArea(
//           child: CustomServerStatusWidget(
//             statusRequest: controller.statusRequest,
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 15.w,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     translateDatabase(
//                       arabic: controller.product?.titleAr ?? "",
//                       english: controller.product?.titleEn ?? "",
//                     ),
//                     style: getSemiBoldStyle(context).copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Gap(20.h),
//                   Stack(
//                     alignment: AlignmentDirectional.bottomEnd,
//                     children: [
//                       WidgetZoom(
//                         heroAnimationTag:
//                             controller.product?.id.toString() ?? "hero",
//                         zoomWidget: ClipRRect(
//                           borderRadius: BorderRadius.circular(10.r),
//                           child: CachedNetworkImage(
//                             imageUrl: controller.product?.image ?? "",
//                             fit: BoxFit.cover,
//                             height: context.isTablet ? 160.h : 120.h,
//                             width: double.infinity,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: context.isTablet ? 160.h : 120.h,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.0),
//                           color: blackColor.withAlpha(170),
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.black.withAlpha(200),
//                               Colors.transparent,
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 15.w,
//                           vertical: 5.h,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(4.r),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 2,
//                               offset: Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Text(
//                           "-${controller.product?.discount ?? "0"}%",
//                           style: context.isTablet
//                               ? getRegularStyle(context).copyWith(
//                                   color: whiteColor,
//                                   fontWeight: FontManager.boldFontWeight,
//                                 )
//                               : getLightStyle(context).copyWith(
//                                   color: whiteColor,
//                                   fontWeight: FontManager.boldFontWeight,
//                                 ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Gap(20.h),
//                   Text(
//                     "Training Sessions".tr,
//                     style: getSemiBoldStyle(context).copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Gap(20.h),
//                   ExpansionPanelList(
//                     expandedHeaderPadding: EdgeInsets.only(bottom: 15),
//                     elevation: 1,
//                     materialGapSize: 20.h,
//                     expandIconColor: blackColor,
//                     expansionCallback: (int index, bool isExpanded) {
//                       controller.callBackFun(index, isExpanded);
//                     },
//                     children: controller.descriptions
//                         .map<ExpansionPanel>((ProductDescriptionModel item) {
//                       return ExpansionPanel(
//                           headerBuilder:
//                               (BuildContext context, bool isExpanded) {
//                             return Container(
//                               decoration: BoxDecoration(
//                                 // border:
//                                 //     Border.all(color: greyColor.withAlpha(100)),
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 color: isExpanded
//                                     ? Colors.indigo.withAlpha(170)
//                                     : null,
//                                 gradient: isExpanded
//                                     ? LinearGradient(
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.topRight,
//                                         colors: [
//                                           Colors.indigo.withAlpha(60),
//                                           Colors.indigo.withAlpha(50),
//                                           Colors.indigo.withAlpha(40),
//                                           Colors.indigo.withAlpha(30),
//                                           Colors.indigo.withAlpha(20),
//                                           Colors.indigo.withAlpha(10),
//                                           Colors.transparent,
//                                         ],
//                                       )
//                                     : null,
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           translateDatabase(
//                                               arabic: item.titleAr,
//                                               english: item.titleEn),
//                                           style:
//                                               getMediumStyle(context).copyWith(
//                                             color: blackColor,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                           body: Padding(
//                             padding: EdgeInsets.only(
//                                 bottom: 15.0, left: 20.w, right: 20.w),
//                             child: ListView.separated(
//                               physics: NeverScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               separatorBuilder: (context, index) => Gap(10),
//                               itemCount: item.contents.length,
//                               itemBuilder: (context, i) => Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: Icon(
//                                       Icons.check_circle,
//                                       size: 17.r,
//                                       color: greenColor,
//                                     ),
//                                   ),
//                                   Gap(10.w),
//                                   Expanded(
//                                     child: Text(
//                                       translateDatabase(
//                                           arabic: item.contents[i].contentAr,
//                                           english: item.contents[i].contentEn),
//                                       style: getMediumStyle(context).copyWith(
//                                         color: blackColor,
//                                       ),
//                                       maxLines: 100,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           isExpanded: item.isExpanded == 0 ? false : true);
//                     }).toList(),
//                   ),
//                   Gap(30.h),
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.all(15),
//                     decoration: BoxDecoration(color: Colors.blueGrey),
//                     child: Row(
//                       children: [
//                         Text(
//                           "Training bag Price : ".tr,
//                           style: getMediumStyle(context).copyWith(
//                             fontWeight: FontWeight.bold,
//                             color: whiteColor,
//                           ),
//                         ),
//                         Gap(10.w),
//                         if (controller.product?.discount != "0")
//                           Text(
//                             "${controller.product?.price ?? "0"}\$",
//                             style: getRegularStyle(context).copyWith(
//                               fontWeight: FontManager.lightFontWeight,
//                               color: whiteColor.withAlpha(190),
//                               decorationColor: whiteColor.withAlpha(190),
//                               decoration: TextDecoration.lineThrough,
//                             ),
//                           ),
//                         Gap(6.w),
//                         Text(
//                           controller.product?.discount != "0"
//                               ? "${double.parse(controller.product?.price ?? "0") - (double.parse(controller.product?.discount ?? "0") / 100 * double.parse(controller.product?.price ?? "0"))}\$"
//                               : "${controller.product?.price ?? "0"}\$",
//                           style: getRegularStyle(context).copyWith(
//                               fontWeight: FontManager.boldFontWeight,
//                               color: Colors.amber),
//                         ),
//                       ],
//                     ),
//
//                     // Text(
//                     //   "Training package data",
//                     //   style: TextStyle(
//                     //       fontSize: 15.sp,
//                     //       fontWeight: FontWeight.bold,
//                     //       color: whiteColor),
//                     // ),
//                   ),
//                   Gap(20.h),
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                     decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 250, 250, 249)),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.report_gmailerrorred,
//                               size: 24.r,
//                             ),
//                             Gap(10.w),
//                             Text(
//                               "About the training bag".tr,
//                               style: getSemiBoldStyle(context).copyWith(
//                                 fontWeight: FontManager.semiBoldFontWeight,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Gap(10.h),
//                         Text(
//                           translateDatabase(
//                                 arabic: controller.product?.descriptionAr ?? "",
//                                 english:
//                                     controller.product?.descriptionEn ?? "",
//                               ) +
//                               " ",
//                           style: getMediumStyle(context).copyWith(
//                             fontWeight: FontWeight.normal,
//                             color: const Color.fromARGB(255, 101, 101, 108),
//                           ),
//                           maxLines: 100,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Gap(20.h),
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.all(15),
//                     decoration: BoxDecoration(color: Colors.blueGrey),
//                     child: Text(
//                       "Terms and condition".tr,
//                       style: getMediumStyle(context).copyWith(
//                           fontWeight: FontWeight.bold, color: whiteColor),
//                     ),
//                   ),
//                   Gap(20.h),
//                   Text(
//                     translateDatabase(
//                       arabic: controller.product?.termsAndConditionsAr ?? "",
//                       english: controller.product?.termsAndConditionsEn ?? "",
//                     ),
//                     style: getMediumStyle(context).copyWith(
//                       fontWeight: FontWeight.normal,
//                       color: blackColor,
//                     ),
//                     maxLines: 100,
//                   ),
//                   Gap(40.h),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/shop/shop_cart_controller.dart';
import 'package:flutter/cupertino.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("تفاصيل الحقيبة", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0.5,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 0.08.sh,
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: controller.downloadDemo,
                  icon: Icon(Icons.download, color: Colors.grey[700], size: 18),
                  label: Text("Demo".tr,
                      style:
                          TextStyle(fontSize: 13.sp, color: Colors.grey[700])),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    side: BorderSide(color: Colors.grey.shade300),
                    fixedSize: Size(120.w, 0.056.sh),
                  ),
                ),
              ),
              Gap(8.w),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.shopCart);
                },
                child: Badge(
                  label: Text(
                    Get.put(
                      ShopCartController()..getCart(),
                    ).carts.length.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withAlpha(100)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Icon(
                      CupertinoIcons.cart_fill,
                      color: Colors.green,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
              Gap(10),
              Expanded(
                flex: 2,
                child: CustomLoadingButton(
                  text: "أضف إلى السلة",
                  onPressed: controller.addToCart,
                  backgroundColor: Color(0xffbe0000),
                  borderRadius: 10,
                ),
              ),
            ],
          ),
        ),
        body: CustomServerStatusWidget(
          statusRequest: controller.statusRequest,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translateDatabase(
                    arabic: controller.product?.titleAr ?? "",
                    english: controller.product?.titleEn ?? "",
                  ),
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                ),
                Gap(12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: controller.product?.image ?? "",
                    height: 160.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Gap(10),
                _priceRow(controller),
                Gap(20),
                _section(
                    "حول الحقيبة",
                    Icons.info_outline,
                    translateDatabase(
                      arabic: controller.product?.descriptionAr ?? "",
                      english: controller.product?.descriptionEn ?? "",
                    )),
                Gap(16),
                _section(
                    "الشروط والأحكام",
                    Icons.assignment_turned_in,
                    translateDatabase(
                      arabic: controller.product?.termsAndConditionsAr ?? "",
                      english: controller.product?.termsAndConditionsEn ?? "",
                    )),
                Gap(16),
                Text("جلسات التدريب",
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.w600)),
                Gap(10),
                ...controller.descriptions.map((e) => _sessionItem(context, e)),
                Gap(40),
              ],
            ),
          ),
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
        if (discount > 0)
          Text("\$${price.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              )),
        Gap(8),
        Text("\$${finalPrice.toStringAsFixed(2)}",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800)),
      ],
    );
  }

  Widget _section(String title, IconData icon, String content) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black54, size: 18),
              Gap(8),
              Text(title,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          Gap(8),
          Text(content,
              style: TextStyle(
                  fontSize: 13.sp, color: Colors.black87, height: 1.5)),
        ],
      ),
    );
  }

  Widget _sessionItem(BuildContext context, dynamic e) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        translateDatabase(arabic: e.titleAr, english: e.titleEn),
        style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w600),
      ),
      children: e.contents.map<Widget>((item) {
        return ListTile(
          contentPadding: EdgeInsets.only(left: 0, right: 0),
          horizontalTitleGap: 10,
          dense: true,
          leading: const Icon(Icons.check_circle_outline,
              color: Colors.green, size: 18),
          title: Text(
            translateDatabase(arabic: item.contentAr, english: item.contentEn),
            style: TextStyle(fontSize: 13.sp),
          ),
        );
      }).toList(),
    );
  }
}
