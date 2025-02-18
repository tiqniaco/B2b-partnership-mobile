import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/provider_profile_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PreviousWork extends StatelessWidget {
  const PreviousWork({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProviderProfileController());
    return GetBuilder<ProviderProfileController>(
        builder: (controller) => Expanded(
                child: CustomServerStatusWidget(
              statusRequest: controller.statusRequestPerviousWork,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.separated(
                  itemCount: controller.previousWork.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Gap(14.h),
                  itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.providerPreviousWork);
                    },
                    child: Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                controller.previousWork[index].image!,
                              ))),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: blackColor.withAlpha(95)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Project Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.sp,
                                  color: whiteColor),
                            ),
                            Text(
                              "Cross Axis Alignment border Radius Project Description Project Description Project Description Project Description Project Description Project DescriptionProject Description",
                              style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: whiteColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}
