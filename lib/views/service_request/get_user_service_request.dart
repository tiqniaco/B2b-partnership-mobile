import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/request_services/get_request_service_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/widgets/request_services/service_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class GetUserServiceRequest extends StatelessWidget {
  GetUserServiceRequest({super.key});
  final controller = Get.put(GetRequestServiceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          'Your Posted Services'.tr,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addServicesRequest);
        },
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
      body: GetBuilder<GetRequestServiceController>(
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child:
                  Text("${controller.services.length} ${"Service founded".tr}",
                      style: TextStyle(
                          color: Colors.black87,
                          //fontWeight: FontWeight.w500,
                          fontSize: 12.sp)),
            ),
            Gap(10),
            CustomServerStatusWidget(
              emptyMessage: "you don't add any service posts\nlet's add some",
              statusRequest: controller.statusRequest,
              child: Expanded(
                  child: ListView.separated(
                separatorBuilder: (context, index) => Gap(15),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemCount: controller.services.length,
                itemBuilder: (context, index) => ServiceItem(
                  model: controller.services[index],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
