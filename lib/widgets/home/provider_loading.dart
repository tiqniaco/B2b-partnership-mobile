import 'package:b2b_partenership/core/global/widgets/bar_widget.dart';
import 'package:b2b_partenership/core/global/widgets/shimmer_loading.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProviderLoading extends StatelessWidget {
  const ProviderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: greyColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bar(
              h: 60.h,
              w: 60.h,
              r: 12.r,
            ),
            Gap(8),
            bar(h: 16.h, w: 110.w),
            Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bar(
                  h: 15.h,
                  w: 15.h,
                  r: 20.r,
                ),
                Gap(4),
                bar(
                  h: 15.h,
                  w: 15.h,
                  r: 20.r,
                ),
                Gap(4),
                bar(
                  h: 15.h,
                  w: 15.h,
                  r: 20.r,
                ),
                Gap(4),
                bar(
                  h: 15.h,
                  w: 15.h,
                  r: 20.r,
                ),
              ],
            ),
            Gap(8),
            bar(h: 16.h, w: 130.w),
            Gap(4),
            bar(h: 16.h, w: 130.w),
            // Gap(2),
          ],
        ),
      ),
    );
  }
}
