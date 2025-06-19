import 'dart:developer';

import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/job_details_model.dart';
import 'package:b2b_partenership/views/service_request/add_service_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProviderJobsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  List<JobDetailsModel> jobs = [];
  bool isDeleteLoading = false;

  @override
  void onInit() {
    getJobs();
    super.onInit();
  }

  Future<void> getJobs() async {
    jobs.clear();
    statusRequest = StatusRequest.loading;
    update();
    final response = await CustomRequest(
        path: ApiConstance.getProviderJobs,
        queryParameters: {
          "provider_id": Get.find<AppPreferences>().getUserId(),
        },
        fromJson: (json) {
          debugPrint(json["data"].toString());
          return List<JobDetailsModel>.from(
            json["data"].map((x) => JobDetailsModel.fromJson(x)),
          );
        }).sendGetRequest();
    response.fold((l) {
      log(l.errMsg);
      statusRequest = StatusRequest.error;
    }, (r) {
      jobs = r;
      statusRequest = r.isEmpty ? StatusRequest.noData : StatusRequest.success;
    });
    update();
  }

  void addNewJob() {
    Get.toNamed(AppRoutes.addNewJob);
  }

  void deleteJobsDialog(id) {
    Get.defaultDialog(
      titlePadding: EdgeInsets.only(top: 20, bottom: 8),
      title: "Delete Job".tr,
      titleStyle: TextStyle(fontSize: 16.r),
      middleText: "Are you sure you want to\ndelete this job?".tr,
      middleTextStyle: TextStyle(fontSize: 14.r),
      textConfirm: "Yes".tr,
      confirm: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 30.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: customBorderRadius,
        ),
        child: Center(
          child: Text(
            "Delete".tr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 14.r,
            ),
          ),
        ),
      ),
      onConfirm: () {
        _deleteJobs(id);
      },
    );
  }

  void _deleteJobs(id) async {
    Get.back();
    isDeleteLoading = true;
    update();
    final result = await CustomRequest<String>(
      path: ApiConstance.deleteJob(id),
      fromJson: (json) {
        return json["message"];
      },
    ).sendDeleteRequest();
    result.fold(
      (error) {
        AppSnackBars.error(message: error.errMsg);
        isDeleteLoading = false;
        update();
      },
      (data) {
        // Get.back();
        jobs.clear();
        isDeleteLoading = false;
        update();
        getJobs();
        AppSnackBars.success(message: data);
      },
    );
  }
}
