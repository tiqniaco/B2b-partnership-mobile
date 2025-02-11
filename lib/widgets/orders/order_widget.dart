import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/widgets/orders/print_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryColor)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: primaryColor,
                border: Border(bottom: BorderSide(color: borderColor)),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
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
                  "54467",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                PrintType(
                  type: "completed",
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: whiteColor,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Gap(10),
                rowWidget("Date", "13 gan, 2023", CupertinoIcons.calendar),
                Gap(10),
                Divider(
                  color: borderColor,
                ),
                Gap(10),
                rowWidget(
                    "Schedule", "12:00 am - 10:00 pm", CupertinoIcons.clock),
                Gap(10),
                Divider(
                  color: borderColor,
                ),
                Gap(10),
                rowWidget(
                    "Billed", "150 \$", CupertinoIcons.money_dollar_circle)
              ],
            ),
          )
        ],
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
