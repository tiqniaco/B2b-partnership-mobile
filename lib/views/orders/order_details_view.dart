import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/orders/order_details_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/services/date_time_convertor.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/widgets/shop/shop_item_product_row_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(
      init: OrderDetailsController(),
      builder: (OrderDetailsController controller) => Scaffold(
        appBar: AppBar(
          toolbarHeight: context.isTablet ? 45.h : null,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Number".tr,
                style: TextStyle(
                    fontSize: 14.r,
                    color: blackColor,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                decoration: BoxDecoration(
                    color: primaryColor, borderRadius: customBorderRadius),
                child: Text(
                  controller.orderId.toString(),
                  style: getRegularStyle(context).copyWith(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.r,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
          child: controller.model == null
              ? const Center(child: CircularProgressIndicator())
              : CustomServerStatusWidget(
                  statusRequest: controller.statusRequest,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Material(
                          elevation: 1,
                          borderRadius: customBorderRadius,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 8),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: customBorderRadius,
                            ),
                            child: Column(
                              children: [
                                rowWidget(
                                    "${"Order Status".tr} ",
                                    "${controller.model?.data.status!.capitalizeFirst}"
                                        .tr,
                                    Icons.watch_later),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 54.r),
                                  child: Divider(
                                    color: primaryColor,
                                  ),
                                ),
                                // Gap(8),
                                rowWidget(
                                    "Date".tr,
                                    controller.model?.data.createdAt !=
                                                "null" &&
                                            controller.model?.data.createdAt !=
                                                null
                                        ? DateTimeConvertor.formatDate(
                                            controller.model?.data.createdAt ??
                                                "",
                                          )
                                        : "Invalid Date",
                                    CupertinoIcons.calendar),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 54.r),
                                  child: Divider(
                                    color: primaryColor,
                                  ),
                                ),
                                rowWidget(
                                    "${"Order Total".tr} ",
                                    "${controller.model?.data.totalPrice.toString() ?? ""}\$",
                                    CupertinoIcons.money_dollar_circle),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(16),
                            Text(
                              "Order Items".tr,
                              style: getSemiBoldStyle(context).copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.r,
                                color: blackColor,
                              ),
                            ),
                            Gap(10),
                          ],
                        ),
                      ),
                      SliverList.separated(
                        separatorBuilder: (context, index) => Gap(20.h),
                        itemCount: controller.model?.items.length ?? 0,
                        itemBuilder: (context, index) {
                          return ShopItemProductRowWidget(
                            product: controller.model!.items[index],
                            //showCategories: false,
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.shopProductDetails,
                                arguments: {
                                  "productId":
                                      controller.model!.items[index].id,
                                  'orderStatus':
                                      controller.model?.data.status ?? "",
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  rowWidget(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18.r,
          color: primaryColor,
        ),
        Gap(8.w),
        Text(
          title,
          style: getRegularStyle(Get.context!),
        ),
        Spacer(),
        Text(
          value,
          style: getRegularStyle(Get.context!).copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// class OrderDetailsItemWidget extends StatelessWidget {
//   const OrderDetailsItemWidget({
//     super.key,
//     required this.title,
//     required this.value,
//   });

//   final String title;
//   final String value;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           flex: 1,
//           child: Text(
//             title,
//             style: getMediumStyle(context).copyWith(
//               fontSize: 12.sp,
//               fontWeight: FontManager.regularFontWeight,
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: Text(
//             value,
//             style: getMediumStyle(context).copyWith(
//               fontWeight: FontManager.semiBoldFontWeight,
//               fontSize: 12.sp,
//               color: greenColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
