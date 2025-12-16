import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

Widget priceRow(String? bagPrice, String? bagDiscount,
    {Color? color = whiteColor,
    double priceFontSize = 14,
    double offPrice = 12}) {
  final double price = double.tryParse(bagPrice ?? "0") ?? 0;
  final double discount = double.tryParse(bagDiscount ?? "0") ?? 0;
  final double finalPrice =
      discount > 0 ? price - (discount / 100 * price) : price;

  return Row(
    children: [
      Text(" ﷼ ${finalPrice.toStringAsFixed(1)}",
          style: TextStyle(
              fontSize: priceFontSize.r,
              fontWeight: FontWeight.w700,
              color: color)),
      Gap(8),
      if (discount > 0)
        Text(" ﷼${price.toStringAsFixed(1)}",
            style: TextStyle(
                fontSize: offPrice.r,
                color: color,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.lineThrough,
                decorationStyle: TextDecorationStyle.solid,
                decorationColor: color)),
    ],
  );
}
