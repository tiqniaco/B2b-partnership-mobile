import 'package:b2b_partenership/core/functions/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PlaceHolderWidget extends StatelessWidget {
  const PlaceHolderWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.space,
  });
  final Widget icon;
  final String title;
  final String subTitle;
  final Widget? space;
  @override
  Widget build(BuildContext context) {
    final txt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Gap(2.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: txt.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              fontSize: 18.rf(),
            ),
          ),
          Gap(2.h),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: txt.bodyMedium?.copyWith(
              color: Colors.black54,
              height: 1.4,
              fontSize: 14.rf(),
              fontWeight: FontWeight.normal,
            ),
          ),
          space ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
