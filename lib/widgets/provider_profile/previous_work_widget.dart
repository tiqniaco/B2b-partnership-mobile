import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/previous_work/provider_profile_controller.dart';
import 'package:b2b_partenership/core/functions/get_text_direction.dart';
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
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: borderColor)),
        child: Row(
          children: [
            Container(
              height: 105.h,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        model.image!,
                      ))),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.titleEn!,
                      textDirection: containsArabic(model.titleEn!)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      style: getMediumStyle(context).copyWith(
                        fontWeight: FontWeight.normal,
                        color: blackColor,
                      ),
                    ),
                    Gap(8),
                    Text(
                      model.description!,
                      textDirection: containsArabic(model.titleEn!)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      style: getRegularStyle(context).copyWith(
                          color: Colors.black54, fontWeight: FontWeight.normal),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
