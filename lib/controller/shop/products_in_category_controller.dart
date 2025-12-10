import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/models/shop_category_model.dart';
import 'package:b2b_partenership/models/shop_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProductsInCategoryController extends GetxController {
  StatusRequest productsStatus = StatusRequest.success;
  final searchController = TextEditingController();
  List<ShopProductModel> products = [];
  late ShopCategoryModel model;
  ScrollController productsScrollController = ScrollController();
  int currentPage = 1;
  int totalPages = 1;

  @override
  void onInit() {
    model = Get.arguments["model"];
    getProducts();
    productsScrollController.addListener(() {
      if (productsScrollController.position.pixels ==
          productsScrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getProducts();
        }
      }
    });
    super.onInit();
  }

  Future<void> getProducts({bool firstTime = false}) async {
    if (firstTime) {
      currentPage = 1;
      products.clear();
      productsStatus = StatusRequest.loading;
      update();
    }
    final result = await CustomRequest<List<ShopProductModel>>(
        path: ApiConstance.shopProducts,
        queryParameters: {
          'category_id': model.id,
        },
        data: {
          'page': currentPage,
          if (searchController.text.isNotEmpty) 'search': searchController.text,
        },
        fromJson: (json) {
          currentPage = json['current_page'];
          totalPages = json['last_page'];
          final List<ShopProductModel> products = List<ShopProductModel>.from(
            json['data'].map((x) => ShopProductModel.fromJson(x)),
          );

          return products;
        }).sendGetRequest();

    result.fold(
      (error) {
        Logger().e(error.errMsg);
        productsStatus = StatusRequest.error;
        update();
      },
      (data) {
        products.addAll(data);
        if (products.isEmpty) {
          productsStatus = StatusRequest.noData;
        } else {
          productsStatus = StatusRequest.success;
        }
        update();
      },
    );
  }
}
