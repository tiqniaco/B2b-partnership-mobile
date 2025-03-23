import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/orders/order_details_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/services/date_time_convertor.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:b2b_partenership/widgets/shop/shop_item_product_widget.dart';
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
          title: Text("#${controller.orderId}"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          child: controller.model == null
              ? const Center(child: CircularProgressIndicator())
              : CustomServerStatusWidget(
                  statusRequest: controller.statusRequest,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            OrderDetailsItemWidget(
                              title: "${"Order Status".tr}: ",
                              value:
                                  "${controller.model?.data.status!.capitalizeFirst}"
                                      .tr,
                            ),
                            Gap(10.h),
                            OrderDetailsItemWidget(
                              title: "${"Order Date".tr}: ",
                              value: controller.model?.data.createdAt !=
                                          "null" &&
                                      controller.model?.data.createdAt != null
                                  ? DateTimeConvertor.formatDate(
                                      controller.model?.data.createdAt ?? "",
                                    )
                                  : "Invalid Date",
                            ),
                            Gap(10.h),
                            OrderDetailsItemWidget(
                              title: "${"Order Expiration Date".tr}: ",
                              value: DateTimeConvertor.formatDate(
                                controller.model?.data.expirationDate ?? "",
                              ),
                            ),
                            Gap(10.h),
                            OrderDetailsItemWidget(
                              title: "${"Order Total".tr}: ",
                              value:
                                  "${controller.model?.data.totalPrice.toString() ?? ""}\$",
                            ),
                            Gap(10.h),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(),
                            Text(
                              "${"Order Items".tr}:",
                              style: getSemiBoldStyle(context).copyWith(
                                fontWeight: FontManager.boldFontWeight,
                                color: primaryColor,
                              ),
                            ),
                            Gap(10.h),
                          ],
                        ),
                      ),
                      SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 10.w,
                          childAspectRatio: 1 / 1.2,
                        ),
                        itemCount: controller.model?.items.length ?? 0,
                        itemBuilder: (context, index) {
                          return ShopProductItemWidget(
                            product: controller.model!.items[index],
                            showCategories: false,
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.orderItem,
                                arguments: {
                                  "product": controller.model!.items[index],
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
}

class OrderDetailsItemWidget extends StatelessWidget {
  const OrderDetailsItemWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: greyColor.withAlpha(100),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getMediumStyle(context).copyWith(
              fontWeight: FontManager.semiBoldFontWeight,
            ),
          ),
          Text(
            value,
            style: getMediumStyle(context).copyWith(
              fontWeight: FontManager.semiBoldFontWeight,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
