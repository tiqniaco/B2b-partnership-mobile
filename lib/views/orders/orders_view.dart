import 'package:b2b_partenership/controller/orders/orders_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_sliver_server_status_widget.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/orders/order_filter.dart';
import 'package:b2b_partenership/widgets/orders/order_widget.dart';
import 'package:b2b_partenership/widgets/please_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    if (ApiConstance.token.isEmpty) {
      return const PleaseLoginWidget();
    }
    return GetBuilder<OrdersController>(
        init: OrdersController(),
        builder: (OrdersController controller) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: whiteColor),
              backgroundColor: primaryColor,
              toolbarHeight: context.isTablet ? 45.h : null,
              // automaticallyImplyLeading: false,
              title: Text(
                "My Orders".tr,
                style: getMediumStyle(context).copyWith(color: whiteColor),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  // horizontal: 16.w,
                  //vertical: 10.h,
                  ),
              child: CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            color: primaryColor,
                            child: OrderFilter()),
                        Gap(10.h),
                      ],
                    ),
                  ),
                  CustomSliverServerStatusWidget(
                    statusRequest: controller.statusRequest,
                    child: SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: context.isTablet ? 2 : 1,
                        // mainAxisSpacing: 20.h,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: 2.1,
                      ),
                      itemCount: controller.orders.length,
                      itemBuilder: (context, index) {
                        return OrderWidget(
                          orderModel: controller.orders[index],
                        );
                      },
                      // separatorBuilder: (context, index) => Gap(10.h),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Gap(20.h),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
