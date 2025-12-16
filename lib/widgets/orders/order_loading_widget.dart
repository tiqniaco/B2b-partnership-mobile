import 'package:b2b_partenership/core/global/widgets/bar_widget.dart';
import 'package:b2b_partenership/core/global/widgets/shimmer_loading.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class OrderLoadingWidget extends StatelessWidget {
  const OrderLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 10,
      separatorBuilder: (context, index) => Gap(12),
      itemBuilder: (context, index) => ShimmerLoading(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: greyColor)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      bar(h: 12.h),
                      Gap(16),
                      bar(
                        h: 12.h,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: Column(
                    children: [
                      Gap(16),
                      Row(
                        children: [
                          bar(h: 24.h, w: 24.h, r: 20),
                          Gap(12),
                          Expanded(
                            child: bar(
                              h: 14.h,
                            ),
                          ),
                          Gap(24),
                          bar(
                            h: 12.h,
                          ),
                        ],
                      ),
                      Gap(8),
                      Row(
                        children: [
                          bar(h: 24.h, w: 24.h, r: 20),
                          Gap(12),
                          Expanded(
                            child: bar(
                              h: 14.h,
                            ),
                          ),
                          Gap(24),
                          bar(
                            h: 12.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
