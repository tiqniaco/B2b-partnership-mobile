import 'package:b2b_partenership/core/global/widgets/bar_widget.dart';
import 'package:b2b_partenership/core/global/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SubCategoryLoadingWidget extends StatelessWidget {
  const SubCategoryLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      separatorBuilder: (context, index) => Gap(8),
      itemBuilder: (context, index) => ShimmerLoading(
        child: bar(h: 30.h, w: 200),
      ),
    );
  }
}
