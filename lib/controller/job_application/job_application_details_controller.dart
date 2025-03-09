import 'package:b2b_partenership/models/client_job_application_model.dart';
import 'package:get/get.dart';

class JobApplicationDetailsController extends GetxController {
  ClientJobApplicationModel? model;

  @override
  void onInit() {
    model = Get.arguments['model'];
    super.onInit();
  }
}
