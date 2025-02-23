import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/widgets/request_services/provider_freelance_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../controller/provider/posts/get_provider_request_service_controller.dart';

class GetServiceRequest extends StatelessWidget {
  GetServiceRequest({super.key});
  final controller = Get.put(GetProviderRequestServiceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<GetProviderRequestServiceController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(70),
              Text("FILTERS",
                  style: TextStyle(
                      color: blackColor,
                      letterSpacing: 4,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp)),
              Gap(3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    filterWidget(() {}, "Category", Icons.category_outlined),
                    Gap(10),
                    filterWidget(() {}, "Location", Icons.location_on_outlined),
                    Gap(10),
                    filterWidget(() {}, "Reset", Icons.refresh_outlined),
                  ],
                ),
              ),
              Gap(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text("${controller.services.length}",
                        style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp)),
                    Gap(10),
                    Text("Freelance Service",
                        style: TextStyle(
                            color: blackColor,
                            // fontWeight: FontWeight.w500,
                            fontSize: 15.sp)),
                  ],
                ),
              ),
              Gap(5),
              Expanded(
                  child: ListView.separated(
                separatorBuilder: (context, index) => Gap(25),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemCount: controller.services.length,
                itemBuilder: (context, index) => ProviderFreelanceItem(
                  model: controller.services[index],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget filterWidget(Function() onTap, String title, IconData icon) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Material(
          color: thirdColor.withAlpha(60),
          borderRadius: BorderRadius.circular(5),
          // elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16.sp, color: thirdColor),
                Gap(8),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
