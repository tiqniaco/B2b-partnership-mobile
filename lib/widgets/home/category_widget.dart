import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/functions/responsive_font.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/specialize_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.specializations});
  final List<SpecializeModel> specializations;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: specializations.length,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        separatorBuilder: (context, index) => Gap(6),
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.providersInCategory,
                    arguments: {"model": specializations[index]});
              },
              child: SizedBox(
                width: context.isTablet ? 76.w : 90.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: lightPrimaryColor),
                      child: CachedNetworkImage(
                        imageUrl: specializations[index].image!,
                        height: 40.h,
                      ),
                    ),
                    Gap(8),
                    Text(
                      translateDatabase(
                          arabic: specializations[index].nameAr!,
                          english: specializations[index].nameEn!),
                      textAlign: TextAlign.center,
                      style: getLightStyle(context).copyWith(
                        fontSize: 12.rf(),
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ));
  }
}
