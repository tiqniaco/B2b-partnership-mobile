import 'package:b2b_partenership/core/global/widgets/bar_widget.dart';
import 'package:b2b_partenership/core/global/widgets/shimmer_loading.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ServiceLoadingWidget extends StatelessWidget {
  const ServiceLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: 7,
        separatorBuilder: (context, index) => Gap(16.h),
        itemBuilder: (context, index) => ShimmerLoading(
              child: Container(
                height: 116.h,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        bar(
                          h: 100.h,
                          w: context.isTablet ? 90.w : 110.w,
                        ),
                        Gap(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              bar(h: 16.h, w: double.infinity),
                              Gap(4),
                              bar(h: 16.h, w: double.infinity),
                              Gap(8),
                              bar(h: 16.h, w: double.infinity),
                              Gap(8),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.isTablet ? 12.w : 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    bar(
                                      h: 16.h,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
