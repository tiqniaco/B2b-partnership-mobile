import 'package:b2b_partenership/core/global/widgets/bar_widget.dart';
import 'package:b2b_partenership/core/global/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class WorkCategoryShimmer extends StatelessWidget {
  const WorkCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      child: ShimmerLoading(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            bar(
              h: 40.h,
              w: 40.h,
              r: 30.r,
            ),
            Gap(8),
            bar(),
            Gap(8),
            bar(),
            //Gap(2),
          ],
        ),
      ),
    );
  }
}
