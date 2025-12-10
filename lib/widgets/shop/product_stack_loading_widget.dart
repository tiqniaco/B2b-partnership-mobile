import 'package:b2b_partenership/core/global/widgets/bar_widget.dart';
import 'package:b2b_partenership/core/global/widgets/shimmer_loading.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductStackLoadingWidget extends StatelessWidget {
  const ProductStackLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
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
                        h: 110.h,
                        w: double.infinity,
                        r: 12.r,
                      ),
                      Gap(8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: bar(
                          h: 16.h,
                          w: double.infinity,
                        ),
                      ),
                      Gap(8),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: bar(
                          h: 16.h,
                          w: double.infinity,
                        ),
                      ),

                      // Gap(2),
                    ],
                  ),
                ),
              ),
            ));
  }
}
