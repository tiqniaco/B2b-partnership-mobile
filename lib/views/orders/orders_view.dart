import 'package:b2b_partenership/controller/orders/orders_controller.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/global/widgets/custom_error_widget.dart';
import 'package:b2b_partenership/core/global/widgets/custom_no_connection_widget.dart';
import 'package:b2b_partenership/core/global/widgets/global_server_status_widget.dart';
import 'package:b2b_partenership/core/global/widgets/place_holder.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/orders/order_loading_widget.dart';
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
              title: Text(
                "My Orders".tr,
                style: getMediumStyle(context).copyWith(
                    color: blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.r),
              ),
            ),
            body: CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: [
                if (controller.statusRequest == StatusRequest.noConnection ||
                    controller.statusRequest == StatusRequest.noData ||
                    controller.statusRequest == StatusRequest.error)
                  SliverToBoxAdapter(
                    child: Gap(200),
                  ),
                GlobalServerStatusWidget(
                  statusRequest: controller.statusRequest,
                  errorChild: SliverToBoxAdapter(child: CustomErrorWidget()),
                  noConnectionChild: SliverToBoxAdapter(
                    child: CustomNoConnectionWidget(
                      onTap: () {
                        controller.getOrders();
                      },
                    ),
                  ),
                  noDataChild: SliverToBoxAdapter(
                    child: PlaceHolderWidget(
                        icon: Image.asset("assets/images/no_orders.png"),
                        title: "No Providers Now",
                        subTitle:
                            "No Providers Available Now, Please\ntry again later"),
                  ),
                  loadingChild: OrderLoadingWidget(),
                  successChild: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.isTablet ? 2 : 1,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2.8,
                    ),
                    itemCount: controller.orders.length,
                    itemBuilder: (context, index) {
                      return OrderWidget(
                        orderModel: controller.orders[index],
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Gap(20.h),
                ),
              ],
            ),
          );
        });
  }
}
