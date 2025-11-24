import 'package:b2b_partenership/core/global/widgets/bar_widget.dart';
import 'package:b2b_partenership/core/global/widgets/shimmer_loading.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class JobsLoadingWidget extends StatelessWidget {
  const JobsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
        separatorBuilder: (context, index) => Gap(16),
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
              width: 90.w,
              child: ShimmerLoading(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: greyColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8.0, left: 4, right: 4),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                bar(h: 60.h, w: 60.h, r: 50),
                                Gap(8),
                                bar(h: 14.h, w: 50.w),
                              ],
                            ),
                            Gap(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bar(h: 12.h, w: 150),
                                  Gap(6),
                                  bar(h: 12.h, w: double.infinity),
                                  Gap(6),
                                  bar(h: 12.h, w: double.infinity),
                                  Gap(6),
                                  bar(h: 12.h, w: double.infinity),
                                  Gap(6),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: bar(h: 24.h, w: 60.w)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
