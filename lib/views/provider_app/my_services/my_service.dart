import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/provider/my_services/get_my_service_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/in_category/service_widget_vertical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyService extends StatelessWidget {
  MyService({super.key});
  final controller = Get.put(GetMyServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          'My Services'.tr,
          style: getSemiBoldStyle(context),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 45.r,
        width: 45.r,
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoutes.addProviderService);
          },
          shape: CircleBorder(),
          child: Icon(
            Icons.add,
            size: 25.r,
          ),
        ),
      ),
      body: GetBuilder<GetMyServiceController>(
        builder: (controller) => CustomServerStatusWidget(
          statusRequest: controller.statusRequestServices,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ServiceWidgetVertical(
                  services: controller.providerServices,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
