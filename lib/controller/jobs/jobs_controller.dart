import 'dart:developer';

import 'package:b2b_partenership/core/enums/jobs_contract_type_enum.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/city_model.dart';
import 'package:b2b_partenership/models/country_model.dart';
import 'package:b2b_partenership/models/specialize_model.dart';
import 'package:b2b_partenership/models/sub_specialize_model.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/job_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class JobsController extends GetxController {
  ScrollController scrollController = ScrollController();
  final searchController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.loading;
  List<JobDetailsModel> jobs = [];
  int currentPage = 1;
  int totalPages = 1;

  JobsContractTypeEnum? selectedContractType;
  DateTime? selectedExpiryDate;
  final List<JobsContractTypeEnum> contractTypeList = [
    ...JobsContractTypeEnum.values,
  ];
  StatusRequest statusRequestCountry = StatusRequest.initial;
  StatusRequest statusRequestCity = StatusRequest.initial;
  StatusRequest statusRequestSpecialization = StatusRequest.initial;
  StatusRequest statusRequestSupSpecialization = StatusRequest.initial;

  CountryModel? selectedCountry;
  CityModel? selectedCity;
  SpecializeModel? selectedSpecialization;
  SubSpecializeModel? selectedSubSpecialization;
  List<CountryModel> countryList = [];
  List<CityModel> governmentList = [];
  List<SpecializeModel> specializationList = [];
  List<SubSpecializeModel> subSpecializationList = [];

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      confirmText: "Confirm".tr,
      cancelText: "Cancel".tr,
    );
    if (picked != null && picked != selectedExpiryDate) {
      selectedExpiryDate = picked;
      update(['dropdown']);
    }
  }

  @override
  void onInit() async {
    await getCountries();
    await getSpecialization();
    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getJobs();
        }
      }
    });
    getJobs();
    super.onInit();
  }

  void deleteJobsDialog(id) {
    Get.defaultDialog(
        title: "Delete Job".tr,
        titleStyle: TextStyle(fontSize: 15.sp),
        middleText: "Are you sure you want to\ndelete this job?".tr,
        textConfirm: "Yes".tr,
        textCancel: "No".tr,
        onConfirm: () {
          _deleteJobs(id);
        });
  }

  void _deleteJobs(id) async {
    final result = await CustomRequest<String>(
      path: ApiConstance.deleteJob(id),
      fromJson: (json) {
        return json["message"];
      },
    ).sendDeleteRequest();
    result.fold(
      (error) {
        AppSnackBars.error(message: error.errMsg);
      },
      (data) {
        Get.back();
        jobs.clear();
        getJobs();
        AppSnackBars.success(message: data);
      },
    );
  }

  void showFilterDialog() {
    Get.bottomSheet(
      GetBuilder<JobsController>(
          id: "dropdown",
          builder: (_) {
            return Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: 1.sw,
              height: Get.context!.isTablet ? 0.52.sh : 0.61.sh,
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 16.h,
              ),
              child: Column(
                children: [
                  _buildDropdown<SpecializeModel>(
                    label: "Specialization".tr,
                    items: specializationList,
                    selectedValue: selectedSpecialization,
                    onChanged: (value) {
                      selectedSpecialization = value;
                      getSupSpecialization();
                      update(['dropdown']);
                    },
                    isLoading:
                        statusRequestSpecialization == StatusRequest.loading,
                  ),
                  _buildDropdown<SubSpecializeModel>(
                    label: "Sub Specialization".tr,
                    items: subSpecializationList,
                    selectedValue: selectedSubSpecialization,
                    onChanged: (value) {
                      selectedSubSpecialization = value;
                      update(['dropdown']);
                    },
                    isLoading:
                        statusRequestSupSpecialization == StatusRequest.loading,
                  ),
                  _buildDropdown<CountryModel>(
                    label: "Country".tr,
                    items: countryList,
                    selectedValue: selectedCountry,
                    onChanged: (value) {
                      selectedCountry = value;
                      getCities();
                      update(['dropdown']);
                    },
                    isLoading: statusRequestCountry == StatusRequest.loading,
                  ),
                  _buildDropdown<CityModel>(
                    label: "City".tr,
                    items: governmentList,
                    selectedValue: selectedCity,
                    onChanged: (value) {
                      selectedCity = value;
                      update(['dropdown']);
                    },
                    isLoading: statusRequestCity == StatusRequest.loading,
                  ),
                  _buildDropdown<JobsContractTypeEnum>(
                    label: "Contract Type".tr,
                    items: contractTypeList,
                    selectedValue: selectedContractType,
                    onChanged: (JobsContractTypeEnum? value) {
                      selectedContractType = value;
                      update(['dropdown']);
                    },
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 8.w,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedExpiryDate == null
                                ? "Select Expiry Date".tr
                                : DateFormat('yyyy-MM-dd')
                                    .format(selectedExpiryDate!),
                            style: getRegularStyle(Get.context!),
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(20.h),
                  CustomLoadingButton(
                    onPressed: () {
                      return getJobs(refresh: true).then((_) {
                        Get.back();
                      });
                    },
                    text: "Filter".tr,
                  ),
                  Gap(10.h),
                  CustomLoadingButton(
                    backgroundColor: greyColor,
                    onPressed: () {
                      return resetFilter().then((_) {
                        Get.back();
                      });
                    },
                    text: "Reset".tr,
                  ),
                ],
              ),
            );
          }),
      isScrollControlled: true,
    );
  }

  Future<void> getCountries() async {
    statusRequestCountry = StatusRequest.loading;
    selectedCountry = null;
    update(['dropdown']);
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
      update(['dropdown']);
    }, (r) {
      countryList = r;
      if (r.isEmpty) {
        statusRequestCountry = StatusRequest.noData;
      } else {
        statusRequestCountry = StatusRequest.success;
      }
      update(['dropdown']);
    });
  }

  Future<void> getCities() async {
    statusRequestCity = StatusRequest.loading;
    selectedCity = null;
    update(['dropdown']);
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
      update(['dropdown']);
    }, (r) {
      governmentList.clear();
      governmentList = r;
      statusRequestCity = StatusRequest.success;
      update(['dropdown']);
    });
    update(['dropdown']);
  }

  Future<void> getSpecialization() async {
    statusRequestSpecialization = StatusRequest.loading;
    selectedSpecialization = null;
    update(['dropdown']);
    final response = await CustomRequest(
        path: ApiConstance.getSpecialization,
        fromJson: (json) {
          return json['data']
              .map<SpecializeModel>((e) => SpecializeModel.fromJson(e))
              .toList();
        }).sendGetRequest();
    response.fold(
      (l) {
        statusRequestSpecialization = StatusRequest.error;
        update(['dropdown']);
      },
      (r) {
        specializationList.clear();
        specializationList = r;
        statusRequestSpecialization = StatusRequest.success;
        update(['dropdown']);
      },
    );
  }

  Future<void> getSupSpecialization() async {
    statusRequestSupSpecialization = StatusRequest.loading;
    selectedSubSpecialization = null;
    update(['dropdown']);
    final response = await CustomRequest(
        path: ApiConstance.getSupSpecialization,
        data: {
          "specialization_id": selectedSpecialization?.id,
        },
        fromJson: (json) {
          return json['data']
              .map<SubSpecializeModel>(
                  (type) => SubSpecializeModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold(
      (l) {
        statusRequestSupSpecialization = StatusRequest.error;
        update(['dropdown']);
      },
      (r) {
        subSpecializationList.clear();
        subSpecializationList = r;
        statusRequestSupSpecialization = StatusRequest.success;
        update(['dropdown']);
      },
    );
  }

  Future<void> getJobs({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
      totalPages = 1;
      jobs.clear();
    }
    statusRequest = StatusRequest.loading;
    update();
    final data = {
      'page': currentPage,
      if (searchController.text.isNotEmpty) 'search': searchController.text,
      if (selectedSpecialization != null)
        "specialization_id": selectedSpecialization?.id,
      if (selectedSubSpecialization != null)
        "sub_specialization_id": selectedSubSpecialization?.id,
      if (selectedCountry != null) "country_id": selectedCountry?.id,
      if (selectedCity != null) "government_id": selectedCity?.id,
      if (selectedContractType != null)
        "contract_type": selectedContractType?.value,
      if (selectedExpiryDate != null)
        "expiry_date": DateFormat('yyyy-MM-dd').format(selectedExpiryDate!),
    };
    log(data.toString(), name: 'data');
    final result = await CustomRequest<List<JobDetailsModel>>(
      path: ApiConstance.jobs,
      data: data,
      fromJson: (json) {
        currentPage = json['current_page'];
        totalPages = json['last_page'];
        return List<JobDetailsModel>.from(
          json['data'].map(
            (e) => JobDetailsModel.fromJson(e),
          ),
        );
      },
    ).sendGetRequest();

    result.fold((l) {
      statusRequest = StatusRequest.error;
      update();
    }, (r) {
      jobs.addAll(r);
      if (jobs.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
      update();
    });
  }

  Future<void> resetFilter() async {
    selectedSpecialization = null;
    selectedSubSpecialization = null;
    selectedCountry = null;
    selectedCity = null;
    selectedContractType = null;
    selectedExpiryDate = null;
    searchController.clear();
    currentPage = 1;
    totalPages = 1;
    getJobs(refresh: true);
    update();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

Widget _buildDropdown<T>({
  required String label,
  required List<T> items,
  T? selectedValue,
  required ValueChanged<T?> onChanged,
  bool isLoading = false,
}) {
  return Skeletonizer(
    enabled: isLoading,
    child: Container(
      padding: EdgeInsets.only(bottom: 10.h),
      child: DropdownButton<T>(
        isExpanded: true,
        hint: Text(
          label,
          style: getRegularStyle(Get.context!).copyWith(
            color: blackWithOpacityColor,
          ),
        ),
        style: getRegularStyle(Get.context!),
        value: selectedValue,
        onChanged: onChanged,
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: 20.r,
        ),
        items: items.map((T value) {
          String title = switch (value.runtimeType) {
            const (SpecializeModel) => translateDatabase(
                arabic: (value as SpecializeModel).nameAr ?? "",
                english: (value as SpecializeModel).nameEn ?? "",
              ),
            const (SubSpecializeModel) => translateDatabase(
                arabic: (value as SubSpecializeModel).nameAr ?? "",
                english: (value as SubSpecializeModel).nameEn ?? "",
              ),
            const (CityModel) => translateDatabase(
                arabic: (value as CityModel).nameAr ?? "",
                english: (value as CityModel).nameEn ?? "",
              ),
            const (CountryModel) => translateDatabase(
                arabic: (value as CountryModel).nameAr ?? "",
                english: (value as CountryModel).nameEn ?? "",
              ),
            const (JobsContractTypeEnum) =>
              (value as JobsContractTypeEnum).text,
            Object() => "",
          };
          return DropdownMenuItem<T>(
            value: value,
            child: Text(
              title,
            ),
          );
        }).toList(),
      ),
    ),
  );
}
