import 'package:b2b_partenership/core/services/app_prefs.dart';

import '/controller/previous_work/provider_profile_controller.dart';
import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import '/core/utils/app_snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPreviousWorkController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String pickedImage = '';

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = pickedFile.path;
      update();
    }
  }

  Future<void> editPreviousWork() async {
    if (pickedImage.isEmpty) {
      AppSnackBars.warning(message: 'Please select an image'.tr);
      return;
    }
    final result = await CustomRequest<String>(
      path: ApiConstance.addProviderPreviousWork,
      files: {
        'image': pickedImage,
      },
      data: {
        'provider_id': Get.find<AppPreferences>().getUserRoleId(),
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
