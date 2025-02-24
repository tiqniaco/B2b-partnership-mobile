// ignore_for_file: avoid_print

import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/models/service_feature_model.dart';
import 'package:b2b_partenership/models/services_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        titleStyle: TextStyle(fontSize: 15.sp),
        title: "Contact with :",
        content: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: pageColor, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/whats.png",
                    height: 30.h,
                  ),
                  Gap(10),
                  Text(
                    "+201009112243",
                    style: TextStyle(fontSize: 15.sp),
                  )
                ],
              ),
            ),
            Gap(10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: borderColor, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 13.sp,
                    backgroundColor: Colors.blue[700],
                    child: Icon(
                      CupertinoIcons.phone_fill,
                      size: 16.sp,
                    ),
                  ),
                  Gap(10),
                  Text(
                    "+201009112243",
                    style: TextStyle(fontSize: 15.sp),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
