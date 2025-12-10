import 'package:b2b_partenership/core/global/widgets/bar_widget.dart';
import 'package:b2b_partenership/core/global/widgets/shimmer_loading.dart';
import 'package:b2b_partenership/core/services/responsive_helper.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProviderLoadingWidget extends StatelessWidget {
  const ProviderLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: ResponsiveHelper.getValue(
                thinValue: 1.44,
                extraSmallValue: 1.59,
                smallValue: 1.35,
                mediumValue: 1.55,
                largeValue: 1.1,
                extraLargeValue: 1.1)),
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (context, index) => SizedBox(
              width: 90.w,
              child: ShimmerLoading(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: borderColor),
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
              ),
            ));
  }
}
