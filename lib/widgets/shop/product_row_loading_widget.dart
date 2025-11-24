import 'package:b2b_partenership/core/global/widgets/bar_widget.dart';
import 'package:b2b_partenership/core/global/widgets/shimmer_loading.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductRowLoadingWidget extends StatelessWidget {
  const ProductRowLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: 2,
        itemBuilder: (context, index) => ShimmerLoading(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    bar(
                      h: 90.h,
                      w: 110.h,
                      r: 12.r,
                    ),
                    Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          bar(
                            h: 18.h,
                            w: double.infinity,
                          ),
                          Gap(8),
                          bar(
                            h: 18.h,
                            w: double.infinity,
                          ),
                          Gap(4),
                          bar(h: 18.h, w: 100),
                        ],
                      ),
                    ),

                    // Gap(2),
                  ],
                ),
              ),
            ));
  }
}
