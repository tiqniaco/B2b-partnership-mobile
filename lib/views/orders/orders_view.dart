import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/widgets/orders/order_filter.dart';
import 'package:b2b_partenership/widgets/orders/order_widget.dart';
import 'package:b2b_partenership/widgets/orders/payment_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: Text("My Orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrderFilter(),
                Gap(10.w),
                PaymentFilter(),
              ],
            ),
            Gap(15),
            Expanded(
                child: ListView.separated(
              separatorBuilder: (context, index) => Gap(25),
              itemCount: 5,
              itemBuilder: (context, index) => OrderWidget(),
            ))
          ],
        ),
      ),
    );
  }
}
