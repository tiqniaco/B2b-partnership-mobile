import 'package:b2b_partenership/controller/orders/orders_controller.dart';
import 'package:b2b_partenership/core/enums/store_order_status_enum.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderFilter extends StatelessWidget {
  const OrderFilter({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersController());
    return GetBuilder<OrdersController>(builder: (controller) {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              ...StoreOrderStatusEnum.values.map(
                (e) => InkWell(
                  onTap: () {
                    controller.selectedStatus = e;
                    controller.getOrders();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    margin: EdgeInsetsDirectional.only(
                      end: 8,
                    ),
                    decoration: BoxDecoration(
                      color: controller.selectedStatus == e
                          ? primaryColor
                          : Colors.transparent,
                      border: Border.all(color: primaryColor),
                      borderRadius: customBorderRadius,
                    ),
                    child: Text(
                      e.name.capitalizeFirst!.tr,
                      style: getRegularStyle(context).copyWith(
                        fontWeight: FontWeight.w500,
                        color: controller.selectedStatus == e
                            ? whiteColor
                            : primaryColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
