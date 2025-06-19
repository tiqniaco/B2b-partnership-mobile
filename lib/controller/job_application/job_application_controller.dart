import 'dart:io';

import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobApplicationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String jobId = "";
  final yearsOfExperienceController = TextEditingController();
  final coverLetterController = TextEditingController();
  final skillsController = TextEditingController();
  final availableToStartDateController = TextEditingController();
  final expectedSalaryController = TextEditingController();
  final whyIdealCandidateController = TextEditingController();
  File? resumeFile;

  @override
  void onInit() {
    jobId = Get.arguments['jobId'] ?? "";
    super.onInit();
  }

  Future<void> pickResume() async {
    final picker = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (picker != null) {
      resumeFile = File(picker.files.single.path!);
      update();
    }
  }

  Future<void> submit() async {
    if (resumeFile == null) {
      AppSnackBars.warning(message: "Please upload your resume");
      return;
    }

    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      final result = await CustomRequest<String>(
        path: ApiConstance.jobApplication,
        fromJson: (json) {
          return json['message'];
        },
        data: {
          "job_id": jobId,
          "client_id": Get.find<AppPreferences>().getUserId(),
          "years_of_experience": yearsOfExperienceController.text,
          "cover_letter": coverLetterController.text,
          "skills": skillsController.text,
          "available_to_start_date": availableToStartDateController.text,
          "expected_salary": expectedSalaryController.text,
          "why_ideal_candidate": whyIdealCandidateController.text,
        },
        files: {
          "resume": resumeFile?.path ?? '',
        },
      ).sendPostRequest();

      result.fold((l) {
        AppSnackBars.error(message: l.errMsg);
      }, (r) {
        Get.back();
        AppSnackBars.success(message: r);
      });
    }
  }

  @override
  void onClose() {
    yearsOfExperienceController.dispose();
    coverLetterController.dispose();
    skillsController.dispose();
    availableToStartDateController.dispose();
    expectedSalaryController.dispose();
    whyIdealCandidateController.dispose();
    super.onClose();
  }
}
