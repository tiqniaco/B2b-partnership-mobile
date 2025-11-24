import 'package:b2b_partenership/core/global/widgets/bar_widget.dart';
import 'package:b2b_partenership/core/global/widgets/shimmer_loading.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PostLoadingWidget extends StatelessWidget {
  const PostLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => Gap(16),
        padding: EdgeInsets.symmetric(horizontal: 16),
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
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16, right: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      bar(h: 40.h, w: 40.h, r: 30),
                                      Gap(10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          bar(h: 14.h, w: 120.w),
                                          Gap(4),
                                          bar(h: 14.h, w: 50.w),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Gap(8),
                            bar(h: 24.h, w: 60.h),
                          ],
                        ),
                      ),
                      Gap(5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            bar(h: 14.h, w: double.infinity),
                            Gap(4),
                            bar(h: 14.h, w: double.infinity),
                          ],
                        ),
                      ),
                      Gap(10),
                      bar(h: 140.h, w: double.infinity),
                    ],
                  ),
                ),
              ),
            ));
  }
}
