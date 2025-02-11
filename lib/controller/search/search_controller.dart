// ignore_for_file: avoid_print

import 'package:b2b_partenership/controller/save/saved_controller.dart';
import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/models/city_model.dart';
import 'package:b2b_partenership/models/country_model.dart';
import 'package:b2b_partenership/models/provider_model.dart';
import 'package:b2b_partenership/models/specialize_model.dart';
import 'package:b2b_partenership/models/sub_specialize_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class SearchControllerIM extends GetxController {
  double rating = 0;
  List<ProviderModel> topProviders = [];
  List<CountryModel> countries = [];
  List<CityModel> cities = [];
  StatusRequest statusRequestProviders = StatusRequest.loading;
  late TextEditingController searchController;
  CountryModel? selectedCountry;
  CityModel? selectedCity;
  SpecializeModel? selectedSpecialization;
  SubSpecializeModel? selectedSubSpecialization;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<SpecializeModel> specializations = [];
  List<SubSpecializeModel> subSpecializations = [];
  late String role;
  int currentStep = 0;
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestCity = StatusRequest.loading;
  StatusRequest statusRequestSpecialization = StatusRequest.loading;
  StatusRequest statusRequestSupSpecialization = StatusRequest.loading;
  late String id;
  bool enable = false;

  @override
  Future<void> onInit() async {
    getProviders();
    searchController = TextEditingController();

    await getCountries();
    // getCities();
    await getSpecialization();
    getProviders();
    super.onInit();
  }

  onCountryChanged(value) {
    selectedCountry = value;
    debugPrint('Selected Country: $value');
    enable = true;
    getCities();
    update();
  }

  onCityChanged(value) {
    selectedCity = value;
    debugPrint('Selected city: $value');
    update();
  }

  onSpecializeChanged(value) async {
    selectedSpecialization = value;
    debugPrint('Selected specialize: $value');
    await getSupSpecialization();
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
      //selectedCountry = r[0];
      if (r.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
      update();
    });
  }

  Future<void> getCities() async {
    statusRequestCity = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.cities,
        data: {"country_id": selectedCountry!.id},
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
        //selectedCity = r[0];
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
        //selectedSpecialization = r[0];
        statusRequestSpecialization = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getSupSpecialization() async {
    statusRequestSupSpecialization = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getSupSpecialization,
        data: {"specialization_id": selectedSpecialization!.id},
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
        //  selectedSubSpecialization = r[0];
        statusRequestSupSpecialization = StatusRequest.success;
      }
    });
    update();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  onTapRating(double index) {
    rating = index;
    print(rating);
    update(["rating"]);
  }

  resetRating() {
    rating = 0;
    update(['rating']);
  }

  Future<void> getProviders() async {
    statusRequestProviders = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getTopProviders,
        fromJson: (json) {
          return json["data"]
              .map<ProviderModel>((service) => ProviderModel.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestProviders = StatusRequest.error;
    }, (r) {
      topProviders.clear();
      topProviders = r;
      if (r.isEmpty) {
        statusRequestProviders = StatusRequest.noData;
      } else {
        statusRequestProviders = StatusRequest.success;
      }
    });
    update();
  }


  toggleFavorites(String provId) async {
    final savedController = SavedController();
    await savedController.onTapFavorite(provId);
    getProviders();

    update();
  }


}
