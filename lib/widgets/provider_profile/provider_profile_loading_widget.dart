import 'package:b2b_partenership/core/global/widgets/bar_widget.dart';
import 'package:b2b_partenership/core/global/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProviderProfileLoadingWidget extends StatelessWidget {
  const ProviderProfileLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ShimmerLoading(
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                bar(h: 50.h, w: 50.h, r: 30.r),
                Gap(8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bar(h: 16.h, w: 100.w),
                    Gap(8),
                    Row(
                      children: [
                        bar(h: 12.h, w: 12.h),
                        Gap(8),
                        bar(h: 12.h, w: 12.h),
                        Gap(8),
                        bar(h: 12.h, w: 12.h),
                        Gap(8),
                        bar(h: 12.h, w: 12.h),
                        Gap(8),
                        bar(h: 12.h, w: 12.h),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: bar(
                    h: 35.h,
                  ),
                ),
                Gap(4),
                Expanded(
                  child: bar(
                    h: 35.h,
                  ),
                ),
                Gap(4),
                Expanded(
                  child: bar(
                    h: 35.h,
                  ),
                ),
                Gap(4),
                Expanded(
                  child: bar(
                    h: 35.h,
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    ));
  }
}
