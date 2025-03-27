import 'package:b2b_partenership/controller/shop/shop_product_details_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
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
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 10.h,
          ),
          height: 0.1.sh,
          child: Column(
            children: [
              CustomLoadingButton(
                onPressed: () {
                  return controller.addToCart();
                },
                backgroundColor:
                    controller.product == null ? greyColor : primaryColor,
                text: "Add To Cart".tr,
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
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(20.h),
                  WidgetZoom(
                    heroAnimationTag:
                        controller.product?.id.toString() ?? "hero",
                    zoomWidget: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: CachedNetworkImage(
                        imageUrl: controller.product?.image ?? "",
                        fit: BoxFit.cover,
                        height: 120.h,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Gap(20.h),
                  Text(
                    "Training Sessions",
                    style: TextStyle(
                      fontSize: 18.sp,
                      //fontWeight: FontWeight.bold,
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
                    children:
                        controller.items.map<ExpansionPanel>((String item) {
                      return ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return Container(
                              decoration: BoxDecoration(
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
                                          item,
                                          style: TextStyle(
                                            fontSize: 16.sp,
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
                              itemCount: 5,
                              itemBuilder: (context, index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Icon(
                                      Icons.check_circle,
                                      size: 17.sp,
                                      color: greenColor,
                                    ),
                                  ),
                                  Gap(10.w),
                                  Expanded(
                                    child: Text(
                                      "the first training stage the first training stage the first training stage",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          isExpanded: true);
                    }).toList(),
                  ),
                  Gap(20.h),
                  if (controller.product?.discount != "0")
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
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
                        style: getRegularStyle(context).copyWith(
                          color: whiteColor,
                          fontWeight: FontManager.boldFontWeight,
                        ),
                      ),
                    ),
                  if (controller.product?.discount != "0")
                    Text(
                      "${controller.product?.price ?? "0"}\$",
                      style: getRegularStyle(context).copyWith(
                        fontWeight: FontManager.lightFontWeight,
                        color: blackColor.withAlpha(150),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Gap(5.w),
                  Text(
                    controller.product?.discount != "0"
                        ? "${double.parse(controller.product?.price ?? "0") - (double.parse(controller.product?.discount ?? "0") / 100 * double.parse(controller.product?.price ?? "0"))}\$"
                        : "${controller.product?.price ?? "0"}\$",
                    style: getRegularStyle(context).copyWith(
                        fontWeight: FontManager.boldFontWeight,
                        color: primaryColor),
                  ),
                  Gap(20.h),
                  Text(
                    "Description:".tr,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontManager.semiBoldFontWeight,
                    ),
                  ),
                  Gap(4.h),
                  ReadMoreText(
                    translateDatabase(
                          arabic: controller.product?.descriptionAr ?? "",
                          english: controller.product?.descriptionEn ?? "",
                        ) +
                        " ",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Gap(20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class FactoryCustomerOrder extends StatefulWidget {
//   const FactoryCustomerOrder({super.key});

//   @override
//   State<FactoryCustomerOrder> createState() => _FactoryCustomerOrderState();
// }

// class _FactoryCustomerOrderState extends State<FactoryCustomerOrder> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child: GetBuilder<SalesInvoiceController>(
//       builder: (controller) => ExpansionPanelList(
//         expansionCallback: (int index, bool isExpanded) {
//           controller.callBackFun(index, isExpanded);
//         },
//         children: controller.ordersList
//             .map<ExpansionPanel>((FactoryOrdersModel item) {
//           return ExpansionPanel(
//               headerBuilder: (BuildContext context, bool isExpanded) {
//                 return Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 8),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(30),
//                                 color: blackColor),
//                             child: Text(
//                               item.factoryOrdersSerial!,
//                               style: const TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {},
//                             child: Icon(
//                               Icons.print,
//                               color: blackColor, // Colors.orange[800],
//                               size: 40,
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Price before discount".tr,
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             item.factoryOrdersPriceBefore!.toString(),
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Discount Amount".tr,
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             "${item.factoryOrdersIsDiscount!.toString()} %",
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Price after discount".tr,
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             item.factoryOrdersPriceAfter!.toString(),
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               body: Column(
//                 children: [Text("booboobkob")],
//               ),
//               isExpanded: item.factoryOrdersIsExpanded == 0 ? false : true);
//         }).toList(),
//       ),
//     ));
//   }
// }
