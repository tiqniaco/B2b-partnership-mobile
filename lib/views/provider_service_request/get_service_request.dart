import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/widgets/request_services/service_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../controller/provider_service_request/get_provider_request_service_controller.dart';

class GetServiceRequest extends StatelessWidget {
  GetServiceRequest({super.key});
  final controller = Get.put(GetProviderRequestServiceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          'Available Service',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: primaryColor,
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 4,
                color: Colors.black.withAlpha(30),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.toNamed(AppRoutes.addServicesRequest);
      //   },
      //   shape: CircleBorder(),
      //   child: Icon(Icons.add),
      // ),
      body: GetBuilder<GetProviderRequestServiceController>(
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("${controller.services.length} providers founded",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp)),
            ),
            Gap(10),
            Expanded(
                child: ListView.separated(
              separatorBuilder: (context, index) => Gap(15),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 15),
              itemCount: controller.services.length,
              itemBuilder: (context, index) => ServiceItem(
                model: controller.services[index],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
