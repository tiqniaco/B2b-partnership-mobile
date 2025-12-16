import 'dart:io';

import 'package:b2b_partenership/controller/posts/user_posts_controller.dart';
import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/city_model.dart';
import 'package:b2b_partenership/models/country_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class AddPostController extends GetxController {
  final TextEditingController clientIdController = TextEditingController();
  final TextEditingController governmentIdController = TextEditingController();
  final TextEditingController subSpecializationIdController =
      TextEditingController();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  CountryModel? selectedCountry;
  CityModel? selectedCity;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<CountryModel> countries = [];
  List<CityModel> cities = [];

  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestCity = StatusRequest.loading;
  StatusRequest statusRequestCountry = StatusRequest.loading;

  File? imageFile;

  @override
  Future<void> onInit() async {
    await getCountries();
    getCities();

    super.onInit();
  }

  onCountryChanged(value) {
    selectedCountry = value;
    debugPrint('Selected Country: $value');
    getCities();
    update();
  }

  onCityChanged(value) {
    selectedCity = value;
    debugPrint('Selected city: $value');
    update();
  }

  validUserData(val) {
    if (val.isEmpty) {
      return "can't be empty".tr;
    }
  }

  galleryImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(xfile!.path);
    Get.defaultDialog(
        content: SizedBox(
          width: 300,
          height: 300,
          child: Image.file(
            imageFile!,
            fit: BoxFit.cover,
          ),
        ),
        onCancel: () {
          imageFile = null;
          update();
        },
        onConfirm: () {
          // add();
          Get.back();
        });
    update();
  }

  Future<void> addServices() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      statusRequest = StatusRequest.loading;
      final result = await CustomRequest<Map<String, dynamic>>(
          path: ApiConstance.addServiceRequest,
          fromJson: (json) {
            return json;
          },
          files: {
            if (imageFile != null) "image": imageFile!.path,
          },
          data: {
            "user_id": Get.find<AppPreferences>().getUserId(),
            "governments_id": selectedCity!.id,
            "sub_specialization_id": 66,
            "title_ar": titleController.text,
            "title_en": titleController.text,
            "address": addressController.text,
            "description": descriptionController.text,
          }).sendPostRequest();
      result.fold((l) {
        statusRequest = StatusRequest.error;
        Logger().e(l.errMsg);
        AppSnackBars.error(message: l.errMsg);
        update();
      }, (r) {
        Get.back();
        Get.put(UserPostsController()).getServices();
        AppSnackBars.success(message: r['message']);
        statusRequest = StatusRequest.success;
        update();
      });
    } else {
      AppSnackBars.warning(message: "please fill all fields");
    }
  }

  Future<void> getCountries() async {
    statusRequestCountry = StatusRequest.loading;
    final result = await CustomRequest<List<CountryModel>>(
      path: ApiConstance.countries,
      fromJson: (json) {
        return json['data']
            .map<CountryModel>((element) => CountryModel.fromJson(element))
            .toList(); //. json['data'];
      },
    ).sendGetRequest();

    result.fold((l) {
      statusRequestCountry = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      countries = r;
      selectedCountry = r[0];
      if (r.isEmpty) {
        statusRequestCountry = StatusRequest.noData;
      } else {
        statusRequestCountry = StatusRequest.success;
      }
      update();
    });
  }

  Future<void> getCities() async {
    statusRequestCity = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.cities,
        queryParameters: {"country_id": selectedCountry!.id},
        fromJson: (json) {
          return json['data']
              .map<CityModel>((city) => CityModel.fromJson(city))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestCity = StatusRequest.error;
    }, (r) {
      cities.clear();
      cities = r;
      if (r.isEmpty) {
        statusRequestCity = StatusRequest.noData;
      } else {
        selectedCity = r[0];
        statusRequestCity = StatusRequest.success;
      }
    });
    update();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
