// ignore_for_file: avoid_print

import 'package:b2b_partenership/controller/provider/my_services/get_my_service_controller.dart';
import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/service_feature_model.dart';
import 'package:b2b_partenership/models/services_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ServiceDetailsController extends GetxController {
  bool isOverView = true;
  bool isSeller = false;

  late int serviceId;
  List<ServiceFeatureModel> serviceFeatures = [];
  ServiceModel? service;
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestFeature = StatusRequest.loading;
  StatusRequest statusRequestReview = StatusRequest.loading;

  @override
  void onInit() {
    serviceId = int.parse(Get.arguments['id']);
    getService();
    getServiceFeature();
    // getServiceReview();
    super.onInit();
  }

  onTapOverView() {
    isOverView = true;
    isSeller = false;

    update();
  }

  onTapSeller() {
    isOverView = false;
    isSeller = true;

    update();
  }

  Future<void> getService() async {
    print("get details .........");
    statusRequest = StatusRequest.loading;
    final result = await CustomRequest<ServiceModel>(
      path: ApiConstance.getServiceDetails(serviceId.toString()),
      fromJson: (json) {
        return ServiceModel.fromJson(json);
      },
    ).sendGetRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      service = r;
      statusRequest = StatusRequest.success;
      update();
    });
  }

  Future<void> getServiceFeature() async {
    print("get features .........");
    statusRequestFeature = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getFeatureServices,
        data: {"provider_service_id": serviceId},
        fromJson: (json) {
          return json['data']
              .map<ServiceFeatureModel>(
                  (type) => ServiceFeatureModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestFeature = StatusRequest.error;
      print("==================================");
      Logger().e(l.errMsg);
    }, (r) {
      serviceFeatures.clear();
      statusRequestFeature = StatusRequest.success;
      serviceFeatures = r;

      if (r.isEmpty) {
        statusRequestFeature = StatusRequest.noData;
      } else {
        statusRequestFeature = StatusRequest.success;
      }
    });
    update();
  }

  contactMethods() {
    Get.defaultDialog(
        titleStyle: getMediumStyle,
        title: "Contact with",
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              if (service?.provider?.contactPhone != null)
                ProviderContactMethodWidget(
                  onTap: () {},
                  icon: FontAwesomeIcons.phone,
                  value: service?.provider?.contactPhone ?? "",
                  iconColor: Colors.green,
                ),
              if (service?.provider?.contactEmail != null)
                ProviderContactMethodWidget(
                  onTap: () {},
                  icon: FontAwesomeIcons.envelope,
                  value: service?.provider?.contactEmail ?? "",
                  iconColor: Colors.red,
                ),
              if (service?.provider?.contactWhatsapp != null)
                ProviderContactMethodWidget(
                  onTap: () {},
                  icon: FontAwesomeIcons.whatsapp,
                  value: service?.provider?.contactWhatsapp ?? "",
                  iconColor: whatsappColor,
                ),
              if (service?.provider?.contactTelegram != null)
                ProviderContactMethodWidget(
                  onTap: () {},
                  icon: FontAwesomeIcons.telegram,
                  value: service?.provider?.contactTelegram ?? "",
                  iconColor: telegramColor,
                ),
              if (service?.provider?.contactInstagram != null)
                ProviderContactMethodWidget(
                  onTap: () {},
                  icon: FontAwesomeIcons.instagram,
                  value: service?.provider?.contactInstagram ?? "",
                  iconColor: instagramColor,
                ),
              if (service?.provider?.contactFacebook != null)
                ProviderContactMethodWidget(
                  onTap: () {},
                  icon: FontAwesomeIcons.facebook,
                  value: service?.provider?.contactFacebook ?? "",
                  iconColor: facebookColor,
                ),
              if (service?.provider?.contactLinkedin != null)
                ProviderContactMethodWidget(
                  onTap: () {},
                  icon: FontAwesomeIcons.linkedin,
                  value: service?.provider?.contactLinkedin ?? "",
                  iconColor: linkedinColor,
                ),
              if (service?.provider?.contactWebsite != null)
                ProviderContactMethodWidget(
                  onTap: () {},
                  icon: Icons.web,
                  value: service?.provider?.contactWebsite ?? "",
                  iconColor: Colors.blue,
                ),
            ],
          ),
        ));
  }

  void deleteServiceDialog() {
    Get.defaultDialog(
      title: "Delete Service",
      middleText: "Are you sure you want to delete this service?",
      textConfirm: "Yes",
      textCancel: "No",
      onConfirm: _deleteService,
    );
  }

  void _deleteService() async {
    final result = await CustomRequest<String>(
      path: ApiConstance.deleteProviderService(service?.data?.id ?? ""),
      fromJson: (json) {
        return json["message"];
      },
    ).sendDeleteRequest();
    result.fold(
      (error) {
        AppSnackBars.error(message: error.errMsg);
      },
      (data) {
        Get.back();
        Get.back();
        Get.put(GetMyServiceController()).getServices();
        AppSnackBars.success(message: data);
      },
    );
  }
}

class ProviderContactMethodWidget extends StatelessWidget {
  const ProviderContactMethodWidget({
    super.key,
    required this.icon,
    required this.value,
    required this.onTap,
    required this.iconColor,
  });

  final IconData icon;
  final String value;
  final void Function()? onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 12.h,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 15.sp,
                backgroundColor: iconColor,
                child: Icon(
                  icon,
                  size: 13.sp,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
