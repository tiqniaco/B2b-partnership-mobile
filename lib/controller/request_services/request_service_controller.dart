import 'dart:io';

import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/models/city_model.dart';
import 'package:b2b_partenership/models/country_model.dart';
import 'package:b2b_partenership/models/specialize_model.dart';
import 'package:b2b_partenership/models/sub_specialize_model.dart';
import 'package:b2b_partenership/widgets/request_services/request_service1.dart';
import 'package:b2b_partenership/widgets/request_services/request_service2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class RequestServiceController extends GetxController {
  final TextEditingController clientIdController = TextEditingController();
  final TextEditingController governmentIdController = TextEditingController();
  final TextEditingController subSpecializationIdController =
      TextEditingController();
  final TextEditingController titleArController = TextEditingController();
  final TextEditingController titleEnController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late CountryModel selectedCountry;
  late CityModel selectedCity;
  late SpecializeModel selectedSpecialization;
  late SubSpecializeModel selectedSubSpecialization;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<CountryModel> countries = [];
  List<CityModel> cities = [];
  List<SpecializeModel> specializations = [];
  List<SubSpecializeModel> subSpecializations = [];
  late String role;
  int currentStep = 0;

  List<Widget> get steps => [
        const RequestService1(),
        const RequestService2(),
      ];

  String userType = "customer";

  bool obscureText = true;
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestCity = StatusRequest.loading;
  StatusRequest statusRequestSpecialization = StatusRequest.loading;
  StatusRequest statusRequestSupSpecialization = StatusRequest.loading;
  File? imageFile;
  bool isLoading = false;

  @override
  Future<void> onInit() async {
    //await getCountries();
    //getCities();
    // await getSpecialization();
    //getSupSpecialization();
    super.onInit();
  }

  void nextStep() {
    if (currentStep < steps.length - 1) {
      currentStep++;
      update();
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      update();
    }
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

  onSpecializeChanged(value) {
    selectedSpecialization = value;
    debugPrint('Selected specialize: $value');
    getSupSpecialization();
    update();
  }

  onSubSpecializeChanged(value) {
    selectedSubSpecialization = value;
    debugPrint('Selected sub specialize: $value');
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

  // Future<void> signupProvider() async {
  //   if (formKey.currentState!.validate()) {
  //     statusRequest = StatusRequest.loading;
  //     if (imageFile == null) {
  //       AppSnackBars.warning(message: "upload profile image");
  //     } else if (commercePdfFile == null) {
  //       AppSnackBars.warning(message: "upload commercial register pdf file");
  //     } else if (taxPdfFile == null) {
  //       AppSnackBars.warning(message: "upload tax card pdf file");
  //     } else {
  //       final result = await CustomRequest<Map<String, dynamic>>(
  //           path: ApiConstance.register,
  //           fromJson: (json) {
  //             return json;
  //           },
  //           files: {
  //             "image": imageFile!.path,
  //             "commercial_register": commercePdfFile!.path,
  //             "tax_card": taxPdfFile!.path,
  //           },
  //           data: {
  //             "name": usernameController.text,
  //             "email": emailController.text,
  //             "password": passwordController.text,
  //             "country_code": selectedCountry.code,
  //             "phone": phoneController.text,
  //             "role": "provider",
  //             "government_id": selectedCity.id,
  //             "sub_specialization_id": selectedSubSpecialization.id,
  //             "provider_types_id": selectedType.id,
  //             "bio": bioController.text,
  //           }).sendPostRequest();
  //       result.fold((l) {
  //         statusRequest = StatusRequest.error;
  //         Logger().e(l.errMsg);
  //         AppSnackBars.error(message: l.errMsg);
  //         update();
  //       }, (r) {
  //         AppSnackBars.success(message: r['message']);
  //         statusRequest = StatusRequest.success;
  //         Get.offAllNamed(AppRoutes.login);
  //         update();
  //       });
  //     }
  //   }
  // }

  // Future<void> signupClient() async {
  //   if (formKey.currentState!.validate()) {
  //     statusRequest = StatusRequest.loading;
  //     if (imageFile == null) {
  //       AppSnackBars.warning(message: "upload profile image");
  //     } else {
  //       final result = await CustomRequest<Map<String, dynamic>>(
  //           path: ApiConstance.register,
  //           fromJson: (json) {
  //             return json;
  //           },
  //           files: {
  //             "image": imageFile!.path,
  //           },
  //           data: {
  //             "name": usernameController.text,
  //             "email": emailController.text,
  //             "password": passwordController.text,
  //             "country_code": selectedCountry.code,
  //             "phone": phoneController.text,
  //             "role": "client",
  //             "government_id": selectedCity.id,
  //           }).sendPostRequest();
  //       result.fold((l) {
  //         statusRequest = StatusRequest.error;
  //         Logger().e(l.errMsg);
  //         AppSnackBars.error(message: l.errMsg);
  //         update();
  //       }, (r) {
  //         AppSnackBars.success(message: r['message']);
  //         statusRequest = StatusRequest.success;
  //         Get.offAllNamed(AppRoutes.login);
  //         update();
  //       });
  //     }
  //   }
  // }

  Future<void> getCountries() async {
    statusRequest = StatusRequest.loading;
    final result = await CustomRequest<List<CountryModel>>(
      path: ApiConstance.countries,
      fromJson: (json) {
        return json['data']
            .map<CountryModel>((element) => CountryModel.fromJson(element))
            .toList(); //. json['data'];
      },
    ).sendGetRequest();

    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      print(r);
      countries = r;
      selectedCountry = r[0];
      if (r.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
      update();
    });
  }

  Future<void> getCities() async {
    print(selectedCountry.id);
    statusRequestCity = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.cities,
        data: {"country_id": selectedCountry.id},
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

  Future<void> getSpecialization() async {
    statusRequestSpecialization = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getSpecialization,
        fromJson: (json) {
          return json['data']
              .map<SpecializeModel>((e) => SpecializeModel.fromJson(e))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestSpecialization = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      specializations.clear();
      statusRequestSpecialization = StatusRequest.success;
      specializations = r;
      if (r.isEmpty) {
        statusRequestSpecialization = StatusRequest.noData;
      } else {
        selectedSpecialization = r[0];
        statusRequestSpecialization = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getSupSpecialization() async {
    statusRequestSupSpecialization = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getSupSpecialization,
        data: {"specialization_id": selectedSpecialization.id},
        fromJson: (json) {
          return json['data']
              .map<SubSpecializeModel>(
                  (type) => SubSpecializeModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestSupSpecialization = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      subSpecializations.clear();
      statusRequestSupSpecialization = StatusRequest.success;
      subSpecializations = r;
      if (r.isEmpty) {
        statusRequestSupSpecialization = StatusRequest.noData;
      } else {
        selectedSubSpecialization = r[0];
        statusRequestSupSpecialization = StatusRequest.success;
      }
    });
    update();
  }

  @override
  void dispose() {
    titleArController.dispose();
    titleEnController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
