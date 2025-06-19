import 'package:b2b_partenership/controller/previous_work/provider_profile_controller.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProviderProfileController());
    return GetBuilder<ProviderProfileController>(builder: (controller) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16),
        itemCount: controller.reviews.length,
        itemBuilder: (context, index) {
          final review = controller.reviews[index];
          return ReviewItem(
            name: review.name!,
            rating: int.parse(review.rating!),
            comment: review.review!,
            color: controller.getRandomColor(),
          );
        },
      );
    });
  }
}

class ReviewItem extends StatelessWidget {
  final String name;
  final int rating;
  final String comment;
  final Color color;

  const ReviewItem(
      {super.key,
      required this.name,
      required this.rating,
      required this.comment,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.white,
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 18.r,
              child: Text(
                name[0],
                style: getMediumStyle(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Gap(15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: getMediumStyle(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      5,
                      (index) {
                        return Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: index < rating ? starColor : greyColor,
                          size: 15.r,
                        );
                      },
                    ),
                  ),
                  Text(
                    comment,
                    style: getRegularStyle(context),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
