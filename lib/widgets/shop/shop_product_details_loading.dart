import 'package:b2b_partenership/core/global/widgets/bar_widget.dart';
import 'package:b2b_partenership/core/global/widgets/shimmer_loading.dart';
import 'package:b2b_partenership/core/services/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ShopProductDetailsLoading extends StatelessWidget {
  const ShopProductDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    bar(h: 20.r, w: 150.w),
                    bar(h: 34.r, w: 90),
                  ],
                ),
                Gap(12),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
                  child: bar(
                    h: 180.h,
                    r: 8,
                    w: double.infinity,
                  ),
                ),
                Gap(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: bar(h: 18.r, w: double.infinity),
                ),
                Gap(4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: bar(h: 18.r, w: double.infinity),
                ),
                Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      bar(h: 16.r),
                      Gap(12),
                      bar(h: 16.r),
                    ],
                  ),
                ),
                Gap(24),
                Row(
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
                  ],
                ),
                Gap(30),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      childAspectRatio: ResponsiveHelper.getValue(
                          thinValue: 0.9, // 393
                          extraSmallValue: 1, // 450
                          smallValue: 1.3, // 600
                          mediumValue: 1.5, // 900
                          largeValue: 1.9, // 1200
                          extraLargeValue: 2.4)),
                  itemBuilder: (context, index) => Column(
                    children: [
                      bar(h: 70.h, w: 70.h, r: 40.r),
                      Gap(8),
                      bar(h: 16.h),
                    ],
                  ),
                  shrinkWrap: true,
                  itemCount: 6,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
