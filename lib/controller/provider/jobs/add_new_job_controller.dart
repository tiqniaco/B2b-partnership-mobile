import 'dart:developer';

import 'package:b2b_partenership/controller/provider/jobs/provider_jobs_controller.dart';
import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/job_gender_enum.dart';
import 'package:b2b_partenership/core/enums/jobs_contract_type_enum.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/city_model.dart';
import 'package:b2b_partenership/models/country_model.dart';
import 'package:b2b_partenership/models/job_details_model.dart';
import 'package:b2b_partenership/models/specialize_model.dart';
import 'package:b2b_partenership/models/sub_specialize_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AddNewJobController extends GetxController {
  JobDetailsModel? model;
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestCity = StatusRequest.loading;
  StatusRequest statusRequestCountry = StatusRequest.loading;
  StatusRequest statusRequestSpecialization = StatusRequest.loading;
  StatusRequest statusRequestSupSpecialization = StatusRequest.loading;

  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  List<CountryModel> countries = [];
  List<CityModel> cities = [];
  List<SpecializeModel> specializations = [];
  List<SubSpecializeModel> subSpecializations = [];

  JobsContractTypeEnum? selectedContractType;
  JobGenderEnum? selectedGender;

  CountryModel? selectedCountry;
  CityModel? selectedCity;
  SpecializeModel? selectedSpecialization;
  SubSpecializeModel? selectedSubSpecialization;
  String errorMessage = '';

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      model = Get.arguments['model'];
      titleController.text = model?.title ?? '';
      descriptionController.text = model?.description ?? '';
      skillsController.text = model?.skills ?? '';
      experienceController.text = model?.experience ?? '';
      expiryDateController.text = model?.expiryDate ?? '';
      salaryController.text =
          model?.salary != "null" ? model!.salary.toString() : '';
      selectedContractType =
          model?.contractType ?? JobsContractTypeEnum.fullTime;
      selectedGender = JobGenderEnum.values.firstWhere(
        (element) => element.name == model!.gender,
      );
    }
    await _init();
    super.onInit();
  }

  Future<void> _init() async {
    try {
      await getCountries();
      if (model != null) {
        selectedCountry = countries.firstWhere(
          (element) => element.id!.toString() == model!.countryId,
        );
      }
      await getCities();
      if (model != null) {
        selectedCity = cities.firstWhere(
          (element) => element.id!.toString() == model!.governmentId,
        );
      }
      await getSpecialization();
      if (model != null) {
        selectedSpecialization = specializations.firstWhere(
          (element) => element.id!.toString() == model!.specializationId,
        );
      }
      await getSupSpecialization();
      if (model != null) {
        selectedSubSpecialization = subSpecializations.firstWhere(
          (element) => element.id!.toString() == model!.subSpecializationId,
        );
      }
      statusRequest = StatusRequest.success;
      update();
      log('init');
    } catch (e) {
      Logger().e(e);
      statusRequest = StatusRequest.error;
      errorMessage = e.toString();
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
        data: {"country_id": selectedCountry?.id},
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
        data: {"specialization_id": selectedSpecialization?.id},
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

  Future<void> addNewJob() async {
    statusRequest = StatusRequest.loading;
    update();
    final response = await CustomRequest<String>(
      path: ApiConstance.addNewJob,
      data: {
        'employer_id': Get.find<AppPreferences>().getUserRoleId(),
        "title": titleController.text,
        "description": descriptionController.text,
        "skills": skillsController.text,
        "experience": experienceController.text,
        "expiry_date": expiryDateController.text,
        if (salaryController.text.isNotEmpty) "salary": salaryController.text,
        'contract_type': selectedContractType?.value,
        'gender': selectedGender?.name,
        "sub_specialization_id": selectedSubSpecialization?.id,
        "government_id": selectedCity?.id,
      },
      fromJson: (json) => json['message'],
    ).sendPostRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      errorMessage = l.errMsg;
      update();
    }, (r) {
      Get.back();
      AppSnackBars.success(message: r);
    });
  }

  Future<void> editJob() async {
    statusRequest = StatusRequest.loading;
    update();
    final response = await CustomRequest<String>(
      path: ApiConstance.editJob(model?.id ?? ''),
      data: {
        if (titleController.text.isNotEmpty) "title": titleController.text,
        if (descriptionController.text.isNotEmpty)
          "description": descriptionController.text,
        if (skillsController.text.isNotEmpty) "skills": skillsController.text,
        if (experienceController.text.isNotEmpty)
          "experience": experienceController.text,
        if (expiryDateController.text.isNotEmpty)
          "expiry_date": expiryDateController.text,
        if (salaryController.text.isNotEmpty) "salary": salaryController.text,
        'contract_type': selectedContractType?.value,
        'gender': selectedGender?.name,
        "sub_specialization_id": selectedSubSpecialization?.id,
        "governments_id": selectedCity?.id,
      },
      fromJson: (json) => json['message'],
    ).sendPatchRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      errorMessage = l.errMsg;
      update();
    }, (r) {
      Get.back();
      Get.put(ProviderJobsController()).getJobs();
      AppSnackBars.success(message: r);
    });
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    skillsController.dispose();
    experienceController.dispose();
    expiryDateController.dispose();
    salaryController.dispose();
    super.onClose();
  }
}
