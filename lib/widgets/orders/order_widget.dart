import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/services/date_time_convertor.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
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
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.orderDetails,
          arguments: {
            "id": orderModel.id.toString(),
          },
        );
      },
      child: Container(
        //padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: primaryColor,
                border: Border(bottom: BorderSide(color: borderColor)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "#",
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    orderModel.id.toString(),
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  PrintType(
                    type: orderModel.status!,
                  ),
                  Gap(4.w),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Gap(10),
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
                  Gap(10),
                  Divider(
                    color: borderColor,
                  ),
                  Gap(10),
                  rowWidget(
                    "Expiry Date".tr,
                    // orderModel.expirationDate!
                    DateTimeConvertor.formatDate(
                      orderModel.expirationDate!,
                    ),

                    CupertinoIcons.clock,
                  ),
                  Gap(10),
                  Divider(
                    color: borderColor,
                  ),
                  Gap(10),
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
    );
  }

  rowWidget(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
        ),
        Gap(8.w),
        Text(
          title,
          style: TextStyle(fontSize: 14.sp),
        ),
        Spacer(),
        Text(value, style: TextStyle(fontSize: 13.sp)),
      ],
    );
  }
}
