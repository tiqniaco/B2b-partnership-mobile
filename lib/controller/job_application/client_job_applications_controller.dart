import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/job_application_status_enum.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/client_job_application_model.dart';
import 'package:get/get.dart';

class ClientJobApplicationsController extends GetxController {
  List<ClientJobApplicationModel> jobApplications = [];
  StatusRequest statusRequest = StatusRequest.loading;

  JobApplicationStatusEnum jobApplicationStatus = JobApplicationStatusEnum.all;

  @override
  Future<void> onInit() async {
    await getJobApplications();
    super.onInit();
  }

  Future<void> getJobApplications() async {
    statusRequest = StatusRequest.loading;
    update();
    final result = await CustomRequest<List<ClientJobApplicationModel>>(
      path: ApiConstance.clientJobApplications,
      data: {
        'user_id': Get.find<AppPreferences>().getUserId(),
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
      statusRequest = StatusRequest.error;
      AppSnackBars.error(message: l.errMsg);
    }, (r) {
      jobApplications = r;
      if (jobApplications.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
    });
    update();
  }
}
