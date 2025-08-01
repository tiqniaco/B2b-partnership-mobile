// ignore_for_file: avoid_print

import '/controller/previous_work/provider_profile_controller.dart';
import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/pervious_work_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditPreviousWorkController extends GetxController {
  late ProviderPerviousWorkModel model;
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String pickedImage = '';

  @override
  void onInit() {
    model = Get.arguments['model'];
    titleController.text = model.titleEn ?? '';
    descriptionController.text = model.description ?? '';

    super.onInit();
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = pickedFile.path;
      update();
    }
  }

  Future<void> editPreviousWork() async {
    final result = await CustomRequest<String>(
      path: ApiConstance.updateProviderPreviousWork(model.id.toString()),
      files: {
        if (pickedImage.isNotEmpty) 'image': pickedImage,
      },
      data: {
        'title_en': titleController.text,
        'title_ar': titleController.text,
        'description': descriptionController.text,
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
        Get.back();
        AppSnackBars.success(message: data);
        Get.put(ProviderProfileController()).getPreviousWork();
      },
    );
  }
}
