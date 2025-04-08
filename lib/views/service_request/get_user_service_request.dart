import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/request_services/get_request_service_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/please_login_widget.dart';
import 'package:b2b_partenership/widgets/request_services/service_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class GetUserServiceRequest extends StatelessWidget {
  const GetUserServiceRequest({super.key});
  @override
  Widget build(BuildContext context) {
    if (ApiConstance.token.isEmpty) {
      return const PleaseLoginWidget();
    }
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: whiteColor,
        toolbarHeight: context.isTablet ? 50.h : null,
        title: Text(
          'Your Posted Services'.tr,
          style: getSemiBoldStyle(context).copyWith(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 50.w,
        height: 50.h,
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoutes.addServicesRequest);
          },
          shape: CircleBorder(),
          child: Icon(
            Icons.add,
            size: 25.r,
          ),
        ),
      ),
      body: GetBuilder<GetRequestServiceController>(
        init: GetRequestServiceController(),
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "${controller.services.length} ${"Service founded".tr}",
                style: getLightStyle(context).copyWith(
                  color: Colors.black87,
                  //fontWeight: FontWeight.w500,
                ),
              ),
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
