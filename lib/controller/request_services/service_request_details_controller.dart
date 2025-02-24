import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/models/price_offer_model.dart';
import 'package:b2b_partenership/models/service_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ServiceRequestDetailsController extends GetxController {
  late ServiceRequestModel model;
  List<ModelData> priceOffers = [];
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestOffers = StatusRequest.loading;
  int currentPage = 0;
  int totalPage = 1;
  bool isPageLoading = false;
  final scrollController = ScrollController(
    initialScrollOffset: 0,
    keepScrollOffset: true,
  );
  @override
  void onInit() {
    model = Get.arguments['model'];
    scrollController.addListener(scrollFunction);
    getPriceOffers();
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

  Future<void> getPriceOffers() async {
    if (currentPage < totalPage) {
      isPageLoading = true;
      update();
      statusRequest = StatusRequest.loading;
      final response = await CustomRequest(
          path: ApiConstance.getServicePriceOffer,
          data: {"request_service_id": model.id!, "page": currentPage + 1},
          fromJson: (json) {
            return PriceOfferModel.fromJson(json);
          }).sendGetRequest();
      response.fold((l) {
        statusRequest = StatusRequest.error;
        Logger().e(l.errMsg);
      }, (r) {
        priceOffers.clear();

        priceOffers = r.data!;
        if (r.data!.isEmpty) {
          statusRequest = StatusRequest.noData;
        } else {
          statusRequest = StatusRequest.success;
        }
        totalPage = r.lastPage!;
        currentPage = r.currentPage!;
      });

      isPageLoading = false;
      update();
    }
  }

  Future<void> acceptPriceOffers(String id) async {
    statusRequestOffers = StatusRequest.loading;
    update();
    final response = await CustomRequest<Map<String, dynamic>>(
        path: ApiConstance.acceptPriceOffers(id),
        fromJson: (json) {
          return json;
        }).sendPatchRequest();
    response.fold((l) {
      statusRequestOffers = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      statusRequestOffers = StatusRequest.success;
      priceOffers.clear();
      currentPage = 0;
      totalPage = 0;
      getPriceOffers();
    });

    update();
  }
}
