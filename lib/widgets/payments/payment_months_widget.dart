import 'package:b2b_partenership/controller/settings/provider/my_services/add_provider_service_controller.dart';
import 'package:b2b_partenership/models/months_model.dart';

import 'package:gap/gap.dart';
import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentMonthsWidget extends StatelessWidget {
  const PaymentMonthsWidget({super.key, required this.months});
  final List<PaymentMonths> months;

  @override
  Widget build(BuildContext context) {
    Get.find<AddProviderServiceController>();
    return GetBuilder<AddProviderServiceController>(builder: (controller) {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
              separatorBuilder: (context, index) => Gap(12),
              scrollDirection: Axis.horizontal,
              itemCount: controller.monthsList.length,
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      controller.onTapMonth(controller.monthsList[index]);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: controller.selectedMonth.id ==
                                controller.monthsList[index].id
                            ? primaryColor.withAlpha(20)
                            : whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.withAlpha(80)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            controller.monthsList[index].durationMonths
                                .toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Gap(4),
                          Text(
                            "month",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )));
    });
  }
}
