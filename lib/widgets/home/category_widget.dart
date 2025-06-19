import 'package:b2b_partenership/app_routes.dart';
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
        separatorBuilder: (context, index) => Gap(20),
        itemBuilder: (context, index) => 
        InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.providersInCategory,
                    arguments: {"model": specializations[index]});
              },
              child: SizedBox(
                width: 100.r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: lightPrimaryColor),
                      child: CachedNetworkImage(
                        imageUrl: specializations[index].image!,
                        height: 50.r,
                      ),
                    ),
                    Gap(8),
                    Text(
                      translateDatabase(
                          arabic: specializations[index].nameAr!,
                          english: specializations[index].nameEn!),
                      textAlign: TextAlign.center,
                      style: getLightStyle(context).copyWith(
                        fontSize: 14.r,
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
