import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/job_application_status_enum.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/client_job_application_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchJobApplicationsController extends GetxController {
  final ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.loading;
  List<ClientJobApplicationModel> jobApplications = [];
  int currentPage = 1;
  int totalPages = 1;

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getJobApplications(refresh: false);
        }
      }
    });
    getJobApplications();
    super.onInit();
  }

  Future<void> getJobApplications({bool refresh = true}) async {
    if (refresh) {
      currentPage = 1;
      totalPages = 1;
      jobApplications.clear();
      statusRequest = StatusRequest.loading;
      update();
    }
    final result = await CustomRequest<List<ClientJobApplicationModel>>(
      path: ApiConstance.searchJobApplications,
      data: {
        'page': currentPage,
        if (searchController.text.isNotEmpty) 'search': searchController.text,
      },
      fromJson: (json) {
        currentPage = json['current_page'];
        totalPages = json['last_page'];
        return List<ClientJobApplicationModel>.from(
          json['data'].map(
            (x) => ClientJobApplicationModel.fromJson(x),
          ),
        );
      },
    ).sendGetRequest();

    result.fold((l) {
      statusRequest = StatusRequest.error;
      AppSnackBars.error(message: l.errMsg);
    }, (r) {
      jobApplications.addAll(r);
      if (jobApplications.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
    });
    update();
  }

  changeJobApplicationStatus(
      {required String applicationId,
      required JobApplicationStatusEnum status}) {}
}
