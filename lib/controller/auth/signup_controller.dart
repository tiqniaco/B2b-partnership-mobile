// ignore_for_file: avoid_print

import 'dart:io';

import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/utils/app_snackbars.dart';
import 'package:b2b_partenership/models/city_model.dart';
import 'package:b2b_partenership/models/country_model.dart';
import 'package:b2b_partenership/models/provider_type_model.dart';
import 'package:b2b_partenership/models/spacialize_model.dart';
import 'package:b2b_partenership/models/sub_spacialize_model.dart';
import 'package:b2b_partenership/widgets/auth/provider_signup1.dart';
import 'package:b2b_partenership/widgets/auth/provider_signup2.dart';
import 'package:b2b_partenership/widgets/auth/provider_signup3.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class SignupController extends GetxController {
  late TextEditingController phoneController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController bioController;
  late TextEditingController commercialController;
  late TextEditingController taxCartController;
  late CountryModel selectedCountry;
  late CityModel selectedCity;
  late ProviderTypeModel selectedType;
  late SpacializModel selectedSpacialization;
  late SubSpacializModel selectedSubSpacialization;
  String phoneNumber = "";
  String countryCode = "+20";

  List<CountryModel> countries = [];
  List<CityModel> cities = [];
  List<ProviderTypeModel> providerTypes = [];
  List<SpacializModel> spacializations = [];
  List<SubSpacializModel> subSpacializations = [];

  int currentStep = 0;

  final List<Widget> providerSteps = [
    const ProviderSignup1(),
    const ProviderSignup2(),
    const ProviderSignup3(),
  ];

  String userType = "customer";
  bool isCustomer = true;
  bool isLaundry = false;
  bool obscureText = true;
  bool customerObscureText = true;
  bool laundryObscureText = true;
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestCity = StatusRequest.loading;
  StatusRequest statusRequestProviderType = StatusRequest.loading;
  StatusRequest statusRequestSpacialization = StatusRequest.loading;
  StatusRequest statusRequestSupSpacialization = StatusRequest.loading;
  GlobalKey<FormState> formKeyCustomer = GlobalKey<FormState>();
  File? imageFile;
  File? commercPdfFile; // ;
  File? taxPdfFile;
  bool isLoading = false;
  late String id;

  @override
  Future<void> onInit() async {
    phoneController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    bioController = TextEditingController();
    commercialController = TextEditingController();
    taxCartController = TextEditingController();
    await getCountries();
    getCities();
    getProviderTyps();
    await getSpacialization();
    getSupSpacialization();
    super.onInit();
  }

  removeFile(String file) {
    if (file == "c") {
      commercPdfFile = null;
      commercialController.clear();
    } else {
      taxPdfFile = null;
      taxCartController.clear();
    }
    update();
  }

  Future<void> pickPDF(String fileName) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      if (fileName == "c") {
        commercPdfFile = File(result.files.single.path!);
        commercialController.text = result.files.single.name;
        print("File selected: ${commercPdfFile!.path}");
      } else {
        taxPdfFile = File(result.files.single.path!);
        taxCartController.text = result.files.single.name;
        print("File selected: ${taxPdfFile!.path}");
      }
    } else {
      print("No file selected");
    }
    printFiles();
    update();
  }

  printFiles() {
    print("=============================");
    print(commercPdfFile);
    print(taxPdfFile);
    print("=============================");
  }

  void nextStep() {
    if (currentStep < providerSteps.length - 1) {
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

  onProviderTypeChanged(value) {
    selectedType = value;
    debugPrint('Selected type: $value');
    update();
  }

  onSpacializChanged(value) {
    selectedSpacialization = value;
    debugPrint('Selected spacializ: $value');
    getSupSpacialization();
    update();
  }

  onSubSpacializChanged(value) {
    selectedSubSpacialization = value;
    debugPrint('Selected sub spacializ: $value');
    update();
  }

  Future<void> changeCustomerPasswordVisibility() async {
    customerObscureText = !customerObscureText;
    update();
  }

  Future<void> changeLaundryPasswordVisibility() async {
    customerObscureText = !customerObscureText;
    update();
  }

  void onPhoneNumberChange(String phone) {
    phoneNumber = phone;
    update();
  }

  void onCountryCodeChanged(String code) {
    countryCode = code;
    update();
  }

  onCustomer() {
    isCustomer = true;
    isLaundry = false;
    userType = "customer";
    debugPrint(userType);
    update();
  }

  onLaundry() {
    isCustomer = false;
    isLaundry = true;
    userType = "laundry";
    debugPrint(userType);
    update();
  }

  validUserData(val) {
    if (val.isEmpty) {
      return "can't be empty".tr;
    }
  }

  gallaryImage() async {
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

  Future<void> signup() async {
    statusRequest = StatusRequest.loading;
    final result = await CustomRequest<Map<String, dynamic>>(
        path: ApiConstance.register,
        fromJson: (json) {
          return json['message'];
        },
        files: {
          "image":imageFile!.path,
          "commercial_register":commercPdfFile!.path,
          "tax_card":taxPdfFile!.path,
        },
        data: {
          "name": usernameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "country_code": selectedCountry.code,
          "phone": phoneController.text,
          "role": "provider",
          "government_id": selectedCity.id,
          "sub_specialization_id": selectedSubSpacialization.id,
          "provider_types_id": selectedType.id,
          "bio": bioController.text,
        }).sendPostRequest();

    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      AppSnackBars.success(message: r['message']);
      statusRequest = StatusRequest.success;

      update();
    });
  }

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

  Future<void> getProviderTyps() async {
    statusRequestProviderType = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getProviderTyps,
        fromJson: (json) {
          return json['data']
              .map<ProviderTypeModel>(
                  (type) => ProviderTypeModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestProviderType = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      providerTypes.clear();
      statusRequestProviderType = StatusRequest.success;
      providerTypes = r;
      if (r.isEmpty) {
        statusRequestProviderType = StatusRequest.noData;
      } else {
        selectedType = r[0];
        statusRequestProviderType = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getSpacialization() async {
    statusRequestProviderType = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getSpacialization,
        fromJson: (json) {
          return json['data']
              .map<SpacializModel>((e) => SpacializModel.fromJson(e))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestSpacialization = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      spacializations.clear();
      statusRequestSpacialization = StatusRequest.success;
      spacializations = r;
      if (r.isEmpty) {
        statusRequestSpacialization = StatusRequest.noData;
      } else {
        selectedSpacialization = r[0];
        statusRequestSpacialization = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getSupSpacialization() async {
    statusRequestSupSpacialization = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getSupSpacialization,
        data: {"specialization_id": selectedSpacialization.id},
        fromJson: (json) {
          return json['data']
              .map<SubSpacializModel>(
                  (type) => SubSpacializModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestSupSpacialization = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      subSpacializations.clear();
      statusRequestSupSpacialization = StatusRequest.success;
      subSpacializations = r;
      if (r.isEmpty) {
        statusRequestSupSpacialization = StatusRequest.noData;
      } else {
        selectedSubSpacialization = r[0];
        statusRequestSupSpacialization = StatusRequest.success;
      }
    });
    update();
  }

  @override
  void dispose() {
    phoneController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    bioController.dispose();
    commercialController.dispose();
    taxCartController.dispose();
    super.dispose();
  }
}
