import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/services/date_time_convertor.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/models/order_model.dart';
import 'package:b2b_partenership/widgets/orders/print_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: InkWell(
        onTap: () {
          Get.toNamed(
            AppRoutes.orderDetails,
            arguments: {
              "id": orderModel.id.toString(),
            },
          );
        },
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: whiteColor,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: lightPrimaryColor.withAlpha(180),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Order Number".tr,
                      style: TextStyle(
                          fontSize: 13.r,
                          color: blackColor,
                          fontWeight: FontWeight.w400),
                    ),
                    Gap(16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8),
                      decoration: BoxDecoration(
                          color: whiteColor, borderRadius: customBorderRadius),
                      child: Text(
                        orderModel.id.toString(),
                        style: getRegularStyle(context).copyWith(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    PrintType(
                      type: orderModel.status!,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: Column(
                  children: [
                    Gap(16),
                    rowWidget(
                      "Date".tr,
                      orderModel.createdAt != null &&
                              orderModel.createdAt != "null"
                          ? DateTimeConvertor.formatDate(
                              orderModel.createdAt!,
                            )
                          : "Invalid Date",
                      CupertinoIcons.calendar,
                    ),
                    Gap(8),
                   
                    rowWidget(
                      "Billed".tr,
                      "${orderModel.totalPrice} \$",
                      CupertinoIcons.money_dollar_circle,
                    )
                  ],
                ),
              )
            ],
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
          size: 16.r,
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
