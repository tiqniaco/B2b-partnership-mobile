import 'package:b2b_partenership/controller/previous_work/previous_work_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:widget_zoom/widget_zoom.dart';

class PreviousWorkView extends StatelessWidget {
  const PreviousWorkView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreviousDetailsWorkController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Previous Work'.tr,
          style: getBoldStyle(context).copyWith(),
        ),
      ),
      body: GetBuilder<PreviousDetailsWorkController>(
        builder: (_) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 170.h,
                  decoration: BoxDecoration(
                      borderRadius: customBorderRadius,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            controller.model.image!,
                          ))),
                ),
                Gap(24),
                Text(
                  controller.model.titleEn ?? '',
                  style: getSemiBoldStyle(context).copyWith(
                    color: Colors.black,
                    fontSize: 20.r,
                  ),
                ),
                Gap(16),
                Text(
                  controller.model.description ?? '',
                  style: getMediumStyle(context).copyWith(
                    fontSize: 14.sp,
                    color: blackColor,
                  ),
                  maxLines: 1000,
                ),
                Gap(20.h),
                Text(
                  'Project Images:'.tr,
                  style: getBoldStyle(context).copyWith(
                    fontSize: 16.r,
                    color: primaryColor,
                  ),
                ),
                Gap(16),
                CustomServerStatusWidget(
                  statusRequest: controller.statusRequest,
                  child: const WorkImage(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class WorkImage extends StatelessWidget {
  const WorkImage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PreviousDetailsWorkController>();

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.7,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: WidgetZoom(
            heroAnimationTag: index.toString(),
            zoomWidget: CustomNetworkImage(
              imageUrl: controller.images[index].image!,
              fit: BoxFit.fitWidth,
            ),
          ),
        );
      },
    );
  }
}
