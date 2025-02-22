import 'package:b2b_partenership/core/services/date_time_convertor.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controllers/notify_controller.dart';

class NotificationWidget extends GetView<NotifyController> {
  const NotificationWidget({
    super.key,
    required this.model,
    required this.onTap,
  });
  final NotificationModel model;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          //border: Border.all(width: 0.2, color: greencolor),
          color: Colors.grey[100]!.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.title,
                  style: getRegularStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateTimeConvertor.timeAgo(
                    model.createdAt,
                  ),
                  //model.notificationsDate!,
                  style: getLightStyle.copyWith(
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Text(
              model.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: getRegularStyle.copyWith(
                fontSize: context.isTablet ? 7.sp : 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
