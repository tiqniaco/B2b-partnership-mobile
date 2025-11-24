import 'package:flutter/material.dart';

Widget bar({double w = 100, double h = 14, double r = 10}) => Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(r),
      ),
    );
