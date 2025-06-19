import 'dart:io';

import 'package:b2b_partenership/controller/shop/shop_cart_controller.dart';
import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/functions/please_login_dialog.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/bag_content_model.dart';
import 'package:b2b_partenership/models/product_description_model.dart';
import 'package:b2b_partenership/models/shop_product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class ShopProductDetailsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  List<ProductDescriptionModel> descriptions = [];
  List<BagContentModel> contents = [];
  ShopProductModel? product;
  String productId = "";
  late PageController pageController;
  int selectedIndex = 0;
  TextDirection textDirection = TextDirection.rtl;

  List<String> items = [
    "First step",
    "Second step",
    "Third step",
    "Fourth step"
  ];

  @override
  void onInit() {
    pageController = PageController(initialPage: selectedIndex);
    productId = Get.arguments?['productId'] as String;
    getProductDetails();

 
    super.onInit();
  }

  bool containsArabic(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text);
  }

  void onPageChanged(int index) {
    selectedIndex = index;
    update();
  }

  void onTabTapped(int index) {
    selectedIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  Future<void> getProductDetails() async {
    statusRequest = StatusRequest.loading;
    update();
    final result = await CustomRequest<Map<String, dynamic>>(
      path: ApiConstance.shopProductDetails(productId),
      fromJson: (json) {
        return json;
      },
    ).sendGetRequest();

    result.fold(
      (l) {
        AppSnackBars.error(message: l.errMsg);
        statusRequest = StatusRequest.error;
        update();
      },
      (data) {
        // print(data);
        product = ShopProductModel.fromJson(data['data']);
        descriptions = List<ProductDescriptionModel>.from(
          data['descriptions'].map(
            (e) => ProductDescriptionModel.fromJson(e),
          ),
        );

        contents = List<BagContentModel>.from(
          data['bagContents'].map(
            (e) => BagContentModel.fromJson(e),
          ),
        );

        statusRequest = StatusRequest.success;
        update();
      },
    );
  }

  Future<void> addToCart() async {
    if (product == null) {
      return;
    }
    if (ApiConstance.token == "") {
      pleaseLoginDialog();
      return;
    }
    await Get.put(ShopCartController()).addToCart(productId: product!.id);
  }

  callBackFun(int index, bool isExpanded) {
    descriptions[index].isExpanded = isExpanded == false ? 0 : 1;

    update();
  }

  Future<void> downloadDemo() async {
    if (product?.file != null) {
      Directory? downloadsDirectory;
      if (Platform.isAndroid) {
        downloadsDirectory = Directory('/storage/emulated/0/Download');
      } else {
        downloadsDirectory = await getApplicationDocumentsDirectory();
      }

      String filePath =
          '${downloadsDirectory.path}/${product!.file.split('/').last}';

      final response = await Dio().download(
        product!.file,
        filePath,
      );
      if (response.statusCode == 200) {
        logger.i(response.statusMessage);
        Get.defaultDialog(
          title: 'File Downloaded'.tr,
          middleText: '${"File downloaded successfully to".tr} $filePath',
        );
      } else {
        AppSnackBars.error(message: 'File download failed');
      }
    } else {
      AppSnackBars.warning(message: 'No file available');
    }
  }
}
