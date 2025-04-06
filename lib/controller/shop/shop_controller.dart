import 'dart:developer';

import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/models/shop_category_model.dart';
import 'package:b2b_partenership/models/shop_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ShopController extends GetxController {
  final searchController = TextEditingController();
  List<ShopCategoryModel> shopCategories = [];
  List<ShopProductModel> shopProducts = [];
  ShopCategoryModel? selectedCategory;

  StatusRequest categoriesStatus = StatusRequest.loading;
  StatusRequest productsStatus = StatusRequest.loading;
  ScrollController productsScrollController = ScrollController();
  int currentPage = 1;
  int totalPages = 1;

  bool showCategories = true;

  void changeShowCategories() {
    showCategories = !showCategories;
    update();
  }

  @override
  Future<void> onInit() async {
    await getShopCategories();
    getShopProducts();

    super.onInit();
  }

  Future<void> getShopCategories() async {
    categoriesStatus = StatusRequest.loading;
    update();
    final result = await CustomRequest<List<ShopCategoryModel>>(
        path: ApiConstance.shopCategories,
        fromJson: (json) {
          final List<ShopCategoryModel> categories =
              List<ShopCategoryModel>.from(
            json['data'].map((x) => ShopCategoryModel.fromJson(x)),
          );

          return categories;
        }).sendGetRequest();
    result.fold(
      (error) {
        Logger().e(error.errMsg);
        categoriesStatus = StatusRequest.error;
        update();
      },
      (data) {
        shopCategories = data;
        if (data.isEmpty) {
          categoriesStatus = StatusRequest.noData;
        } else {
          categoriesStatus = StatusRequest.success;
        }
        update();
      },
    );
  }

  Future<void> getShopProducts() async {
    shopProducts.clear();
    productsStatus = StatusRequest.loading;
    final result = await CustomRequest<List<ShopProductModel>>(
        path: ApiConstance.topRatedProducts,
        data: {
          if (selectedCategory != null) 'category_id': selectedCategory?.id,
        },
        fromJson: (json) {
          // log(json['data'].toString());

          final List<ShopProductModel> products = List<ShopProductModel>.from(
            json['data'].map((x) => ShopProductModel.fromJson(x)),
          );
          return products;
        }).sendGetRequest();
    result.fold(
      (error) {
        // Logger().e(error.errMsg);
        productsStatus = StatusRequest.error;
        update();
      },
      (data) {
        shopProducts.addAll(data);
        if (shopProducts.isEmpty) {
          productsStatus = StatusRequest.noData;
        } else {
          productsStatus = StatusRequest.success;
        }
        update();
      },
    );
  }

  void onTapCategory(int index) {
    selectedCategory = shopCategories[index];
    getShopProducts();
    update();
  }
}
