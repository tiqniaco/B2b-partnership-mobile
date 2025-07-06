import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/city_model.dart';
import 'package:b2b_partenership/models/country_model.dart';
import 'package:b2b_partenership/models/price_offer_model.dart';
import 'package:b2b_partenership/models/service_request_model.dart';
import 'package:b2b_partenership/models/specialize_model.dart';
import 'package:b2b_partenership/models/sub_specialize_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class PostDetailsController extends GetxController {
  late ServiceRequestModel model;
  List<PriceOfferModel> priceOffers = [];
  List<PriceOfferModel> providerOffers = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestOffers = StatusRequest.loading;

  StatusRequest statusRequestSearch = StatusRequest.loading;
  StatusRequest statusRequestCity = StatusRequest.loading;
  StatusRequest statusRequestSpecialization = StatusRequest.loading;
  StatusRequest statusRequestSupSpecialization = StatusRequest.loading; //
  int currentPage = 0;
  int totalPage = 1;
  bool isPageLoading = false;
  final scrollController = ScrollController(
    initialScrollOffset: 0,
    keepScrollOffset: true,
  );

  CountryModel? selectedCountry;
  CityModel? selectedCity;
  SpecializeModel? selectedSpecialization;
  SubSpecializeModel? selectedSubSpecialization;

  List<CountryModel> countries = [];
  List<CityModel> cities = [];
  List<SpecializeModel> specializations = [];
  List<SubSpecializeModel> subSpecializations = [];
  bool enable = false;

  @override
  void onInit() {
    model = Get.arguments['model'];
    scrollController.addListener(scrollFunction);

    if (Get.find<AppPreferences>().getUserId() == model.userId) {
      getPriceOffers();
    } else {
      getProviderOffers();
    }
    super.onInit();
  }

  scrollFunction() async {
    if (isPageLoading) {
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getPriceOffers();
    }
  }

  void addPriceDialog() {
    Get.dialog(
      GetBuilder<PostDetailsController>(
        init: PostDetailsController(),
        builder: (PostDetailsController controller) {
          return AlertDialog(
            title: Text('Add Price Offer'.tr),
            titleTextStyle: TextStyle(
                fontSize: 16.r, fontWeight: FontWeight.bold, color: blackColor),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: priceController,
                    maxLines: null,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        hintStyle: TextStyle(fontSize: 13.sp),
                        hintText: 'Price'.tr),
                  ),
                  Gap(10.h),
                  TextFormField(
                    controller: durationController,
                    maxLines: null,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        hintStyle: TextStyle(fontSize: 13.sp),
                        hintText: 'Duration'.tr),
                  ),
                  Gap(10.h),
                  TextFormField(
                    controller: descriptionController,
                    minLines: 3,
                    maxLines: 21,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        hintStyle: TextStyle(fontSize: 13.sp),
                        hintText: 'Description'.tr),
                  ),
                ],
              ),
            ),
            actions: [
              CustomLoadingButton(
                text: "Submit".tr,
                onPressed: () {
                  return _addOffer();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addOffer() async {
  
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;

      final result = await CustomRequest<Map<String, dynamic>>(
          path: ApiConstance.addPriceOffer,
          fromJson: (json) {
            return json;
          },
          data: {
            "user_id": Get.find<AppPreferences>().getUserId(),
            "request_service_id": model.id,
            "offer_description": descriptionController.text,
            "price": priceController.text,
            "duration": durationController.text
          }).sendPostRequest();
      result.fold((l) {
        statusRequest = StatusRequest.error;
        Logger().e(l.errMsg);
        AppSnackBars.error(message: l.errMsg);
        update();
      }, (r) {
        AppSnackBars.success(message: r['message']);
        getProviderOffers();
        update();
      });
    }
  }

  Future<void> deleteOffer(String id) async {
    statusRequest = StatusRequest.loading;

    final result = await CustomRequest<Map<String, dynamic>>(
        path: ApiConstance.deletePriceOffer(id),
        fromJson: (json) {
          return json;
        }).sendDeleteRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      AppSnackBars.error(message: l.errMsg);
      update();
    }, (r) {
      AppSnackBars.success(message: r['message']);

      getProviderOffers();
      update();
    });
  }

  Future<void> getPriceOffers({bool reset = false}) async {
    if (reset) {
      currentPage = 0;
      totalPage = 0;
      priceOffers.clear();
      update();
    }
    if (currentPage < totalPage) {
      isPageLoading = true;
      update();
      statusRequest = StatusRequest.loading;
      final response = await CustomRequest(
          path: ApiConstance.getServicePriceOffer,
          data: {
            "request_service_id": model.id!,
          },
          fromJson: (json) {
            return json["data"]
                .map<PriceOfferModel>(
                    (offer) => PriceOfferModel.fromJson(offer))
                .toList();
          }).sendGetRequest();
      response.fold((l) {
        statusRequest = StatusRequest.error;
        Logger().e(l.errMsg);
      }, (r) {
        priceOffers.clear();

        priceOffers = r;
        if (r.isEmpty) {
          statusRequest = StatusRequest.noData;
        } else {
          statusRequest = StatusRequest.success;
        }
      });

      isPageLoading = false;
      update();
    }
  }

  Future<void> getProviderOffers() async {
    statusRequest = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getProviderOffersInPost,
        data: {"request_service_id": model.id!},
        fromJson: (json) {
          return json["data"]
              .map<PriceOfferModel>((offer) => PriceOfferModel.fromJson(offer))
              .toList();
        }).sendPostRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      providerOffers.clear();
      providerOffers = r;
      if (r.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> acceptPriceOffers(String id) async {
    statusRequestOffers = StatusRequest.loading;
    update();
    final response = await CustomRequest<Map<String, dynamic>>(
        path: ApiConstance.acceptPriceOffers(id),
        fromJson: (json) {
          return json;
        }).sendPatchRequest();
    response.fold(
      (l) {
        statusRequestOffers = StatusRequest.error;
        Logger().e(l.errMsg);
      },
      (r) {
        statusRequestOffers = StatusRequest.success;
        getPriceOffers(reset: true);
        update();
      },
    );
    update();
  }
}
