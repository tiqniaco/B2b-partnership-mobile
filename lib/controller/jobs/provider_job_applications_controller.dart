import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/job_application_status_enum.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/client_job_application_model.dart';
import 'package:get/get.dart';

class ProviderJobApplicationsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;

  String jobId = "";
  List<ClientJobApplicationModel> jobApplications = [];
  JobApplicationStatusEnum jobApplicationStatus = JobApplicationStatusEnum.all;

  @override
  void onInit() {
    jobId = Get.arguments?['jobId'] ?? "";
    getJobApplications();
    super.onInit();
  }

  Future<void> getJobApplications({bool hasLoading = true}) async {
    if (hasLoading) {
      statusRequest = StatusRequest.loading;
      update();
    }
    final result = await CustomRequest<List<ClientJobApplicationModel>>(
      path: ApiConstance.providerJobApplications,
      data: {
        'job_id': jobId,
        if (jobApplicationStatus != JobApplicationStatusEnum.all)
          'status': jobApplicationStatus.name,
      },
      fromJson: (json) {
        return List<ClientJobApplicationModel>.from(
          json['data'].map(
            (x) => ClientJobApplicationModel.fromJson(x),
          ),
        );
      },
    ).sendGetRequest();

    result.fold((l) {
      AppSnackBars.error(message: l.errMsg);
      statusRequest = StatusRequest.error;
      update();
    }, (r) {
      jobApplications = r;

      if (jobApplications.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
      update();
    });
  }

  Future<void> changeJobApplicationStatus({
    required String applicationId,
    required JobApplicationStatusEnum status,
  }) async {
    final result = await CustomRequest<String>(
      path: ApiConstance.changeJobApplicationStatus(applicationId),
      data: {
        'status': status.name,
      },
      fromJson: (json) {
        return json['message'];
      },
    ).sendPostRequest();

    result.fold(
      (error) {
        AppSnackBars.error(message: error.errMsg);
      },
      (data) {
        AppSnackBars.success(message: data);
        getJobApplications(hasLoading: false);
      },
    );
  }
}
