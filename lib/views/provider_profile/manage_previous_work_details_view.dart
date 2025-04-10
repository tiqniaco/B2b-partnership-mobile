import 'package:b2b_partenership/controller/previous_work/previous_work_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:widget_zoom/widget_zoom.dart';

class ManagePreviousWorkDetailsView extends StatelessWidget {
  const ManagePreviousWorkDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Previous Work'.tr,
          style: getBoldStyle(context).copyWith(color: primaryColor),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<PreviousDetailsWorkController>(
        init: PreviousDetailsWorkController(),
        builder: (controller) {
          return SizedBox(
            height: 1.sh,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(5.h),
                  Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          controller.model.image!,
                        ),
                      ),
                    ),
                  ),
                  Gap(15.h),
                  Text(
                    controller.model.titleEn ?? '',
                    style: getSemiBoldStyle(context).copyWith(
                      color: Colors.black,
                    ),
                  ),
                  Gap(10.h),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 252, 252, 247)),
                    child: Text(
                      controller.model.description ?? '',
                      style: getMediumStyle(context).copyWith(
                        fontSize: 14.sp,
                        color: Colors.grey[800],
                      ),
                      maxLines: 1000,
                    ),
                  ),
                  Gap(20.h),
                  Row(
                    children: [
                      Text(
                        'Project Images:'.tr,
                        style: getBoldStyle(context).copyWith(
                          fontSize: 14.sp,
                          color: greenColor,
                        ),
                      ),
                      const Spacer(),
                      Material(
                        elevation: 1,
                        shape: CircleBorder(),
                        child: IconButton(
                          onPressed: () {
                            controller.addPreviousWorkImageDialog();
                          },
                          icon: Icon(
                            Icons.add,
                            color: greenColor,
                            size: 20.r,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(10.h),
                  CustomServerStatusWidget(
                    statusRequest: controller.statusRequest,
                    child: const WorkImage(),
                  ),
                ],
              ),
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
    return GetBuilder<PreviousDetailsWorkController>(
      builder: (controller) {
        return GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.images.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 1.6,
          ),
          itemBuilder: (context, index) {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: WidgetZoom(
                    heroAnimationTag: index.toString(),
                    zoomWidget: CustomNetworkImage(
                      imageUrl: controller.images[index].image!,
                      fit: BoxFit.contain,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ),
                IconButton(
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
                    backgroundColor: WidgetStateProperty.all<Color>(whiteColor),
                  ),
                  //color: whiteColor,
                  onPressed: () {
                    controller.deletePreviousWorkImage(index);
                  },
                  icon: controller.images[index].isDeleteLoading
                      ? CircularProgressIndicator()
                      : Icon(
                          Icons.delete,
                          color: primaryColor,
                          size: 20.sp,
                        ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
