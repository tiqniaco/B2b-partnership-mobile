import 'package:b2b_partenership/controller/service_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileServicesWidget extends StatelessWidget {
  const ProfileServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServiceDetailsController());
    return GetBuilder<ServiceDetailsController>(builder: (controller) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16),
        itemCount: controller.servicesReview.length,
        itemBuilder: (context, index) {
          final review = controller.servicesReview[index];
          return ReviewItem(
            name: review.review!,
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
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Text(name[0],
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                        size: 15.sp,
                      );
                    }),
                  ),
                  Text(
                    comment,
                    style: TextStyle(fontSize: 13.sp),
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
