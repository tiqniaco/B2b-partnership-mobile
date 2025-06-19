import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/previous_work/provider_profile_controller.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/pervious_work_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PreviousWork extends StatelessWidget {
  const PreviousWork({super.key, required this.model});
  final ProviderPerviousWorkModel model;
  @override
  Widget build(BuildContext context) {
    Get.put(ProviderProfileController());
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.providerPreviousWork,
            arguments: {"model": model});
      },
      child: Container(
        height: 105.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  model.image!,
                ))),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: blackColor.withAlpha(80)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                model.titleEn!,
                style: getMediumStyle(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                ),
              ),
              Text(
                model.description!,
                style: getRegularStyle(context).copyWith(
                  color: whiteColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
