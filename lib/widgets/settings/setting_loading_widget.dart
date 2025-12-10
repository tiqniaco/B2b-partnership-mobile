import 'package:b2b_partenership/core/global/widgets/bar_widget.dart';
import 'package:b2b_partenership/core/global/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SettingLoadingWidget extends StatelessWidget {
  const SettingLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ShimmerLoading(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Gap(20),
                  Column(
                    children: [bar(h: 60.h, w: 100.w), Gap(10), bar(h: 12.h)],
                  ),
                  Column(
                    children: [
                      bar(h: 20.h, w: 20.h),
                      Gap(4.h),
                      bar(h: 20.h, w: 20.h),
                    ],
                  ),
                ],
              ),
              Gap(10),
              bar(h: 20.h, w: 200.w),
              Gap(24),
              GridView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.isLargeTablet
                      ? 4
                      : context.isTablet
                          ? 3
                          : 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 9 / 3.5,
                ),
                children: [
                  bar(h: 60.h, w: 100),
                  bar(h: 60.h, w: 100),
                  bar(h: 60.h, w: 100),
                  bar(h: 60.h, w: 100),
                ],
              ),
              Gap(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bar(h: 12.h),
                  Gap(16),
                  bar(h: 30.h, w: double.infinity),
                  Gap(8),
                  bar(h: 30.h, w: double.infinity),
                  Gap(8),
                  bar(h: 30.h, w: double.infinity),
                  Gap(8),
                  bar(h: 30.h, w: double.infinity),
                  Gap(24),
                  bar(h: 12.h),
                  Gap(16),
                  bar(h: 30.h, w: double.infinity),
                  Gap(8),
                  bar(h: 30.h, w: double.infinity),
                  Gap(8),
                  bar(h: 30.h, w: double.infinity),
                  Gap(8),
                  bar(h: 30.h, w: double.infinity),
                  Gap(8),
                  bar(h: 30.h, w: double.infinity),
                  Gap(8),
                  bar(h: 30.h, w: double.infinity),
                  Gap(8),
                  bar(h: 30.h, w: double.infinity),
                  Gap(8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
