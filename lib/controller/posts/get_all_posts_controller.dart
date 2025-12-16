import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/functions/internet_check.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/city_model.dart';
import 'package:b2b_partenership/models/country_model.dart';
import 'package:b2b_partenership/models/service_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllPostsController extends GetxController {
  CountryModel? selectedCountry;
  CityModel? selectedCity;

  final searchController = TextEditingController();
  List<CountryModel> countries = [];
  List<CityModel> cities = [];
  List<ServiceRequestModel> services = [];

  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestCity = StatusRequest.loading;
  StatusRequest statusRequestCountry = StatusRequest.loading;

  @override
  Future<void> onInit() async {
    getServices();
    await getCountries();
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

  void showFilterDialog() {
    Get.bottomSheet(
      GetBuilder<AllPostsController>(
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
              height: Get.context!.isTablet ? 0.52.sh : 0.70.sh,
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 16.h,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // _buildDropdown<SpecializeModel>(
                    //   label: "Specialization".tr,
                    //   items: specializationList,
                    //   selectedValue: selectedSpecialization,
                    //   onChanged: (value) {
                    //     selectedSpecialization = value;
                    //     getSupSpecialization();
                    //     update(['dropdown']);
                    //   },
                    //   isLoading:
                    //       statusRequestSpecialization == StatusRequest.loading,
                    // ),
                    // _buildDropdown<SubSpecializeModel>(
                    //   label: "Sub Specialization".tr,
                    //   items: subSpecializationList,
                    //   selectedValue: selectedSubSpecialization,
                    //   onChanged: (value) {
                    //     selectedSubSpecialization = value;
                    //     update(['dropdown']);
                    //   },
                    //   isLoading: statusRequestSupSpecialization ==
                    //       StatusRequest.loading,
                    // ),
                    _buildDropdown<CountryModel>(
                      label: "Country".tr,
                      items: countries,
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
                      items: cities,
                      selectedValue: selectedCity,
                      onChanged: (value) {
                        selectedCity = value;
                        update(['dropdown']);
                      },
                      isLoading: statusRequestCity == StatusRequest.loading,
                    ),
                    // _buildDropdown<JobsContractTypeEnum>(
                    //   label: "Contract Type".tr,
                    //   items: contractTypeList,
                    //   selectedValue: selectedContractType,
                    //   onChanged: (JobsContractTypeEnum? value) {
                    //     selectedContractType = value;
                    //     update(['dropdown']);
                    //   },
                    // ),

                    // GestureDetector(
                    //   onTap: () => _selectDate(),
                    //   child: Container(
                    //     padding: EdgeInsets.symmetric(
                    //       vertical: 10.h,
                    //       horizontal: 8.w,
                    //     ),
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.grey),
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           selectedExpiryDate == null
                    //               ? "Select Expiry Date".tr
                    //               : DateFormat('yyyy-MM-dd')
                    //                   .format(selectedExpiryDate!),
                    //           style: getRegularStyle(Get.context!),
                    //         ),
                    //         Icon(
                    //           Icons.calendar_today,
                    //           color: primaryColor,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    Gap(20.h),

                    CustomLoadingButton(
                      onPressed: () {
                        return getServices().then((_) {
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
              ),
            );
          }),
      isScrollControlled: true,
    );
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
              // const (SpecializeModel) => translateDatabase(
              //     arabic: (value as SpecializeModel).nameAr ?? "",
              //     english: (value as SpecializeModel).nameEn ?? "",
              //   ),
              // const (SubSpecializeModel) => translateDatabase(
              //     arabic: (value as SubSpecializeModel).nameAr ?? "",
              //     english: (value as SubSpecializeModel).nameEn ?? "",
              //   ),
              const (CityModel) => translateDatabase(
                  arabic: (value as CityModel).nameAr ?? "",
                  english: (value as CityModel).nameEn ?? "",
                ),
              const (CountryModel) => translateDatabase(
                  arabic: (value as CountryModel).nameAr ?? "",
                  english: (value as CountryModel).nameEn ?? "",
                ),
              // const (JobsContractTypeEnum) =>
              //   (value as JobsContractTypeEnum).text,
              // Object() => "",

              Type() => throw UnimplementedError(),
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

  Future<void> resetFilter() async {
    selectedCountry = null;
    selectedCity = null;
    searchController.clear();
    getServices();
    update();
  }

  Future<void> getServices() async {
    statusRequest = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getAllPendingServices,
        queryParameters: {
          if (searchController.text.isNotEmpty) 'search': searchController.text,
          if (selectedCountry != null) "country_id": selectedCountry!.id,
          if (selectedCity != null) "government_id": selectedCity!.id,
        },
        fromJson: (json) {
          return json['data']
              .map<ServiceRequestModel>(
                  (type) => ServiceRequestModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      if (isConnectionError(l)) {
        statusRequest = StatusRequest.noConnection;
      } else {
        statusRequest = StatusRequest.error;
      }
      Logger().e(l.errMsg);
    }, (r) {
      services.clear();
      statusRequest = StatusRequest.success;
      services = r;
      if (r.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
    });
    update();
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
            .toList();
      },
    ).sendGetRequest();

    result.fold((l) {
      statusRequestCountry = StatusRequest.error;
      update(['dropdown']);
    }, (r) {
      countries = r;
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
        queryParameters: {"country_id": selectedCountry?.id},
        fromJson: (json) {
          return json['data']
              .map<CityModel>((city) => CityModel.fromJson(city))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestCity = StatusRequest.error;
      update(['dropdown']);
    }, (r) {
      cities.clear();
      cities = r;
      statusRequestCity = StatusRequest.success;
      update(['dropdown']);
    });
    update(['dropdown']);
  }
}
