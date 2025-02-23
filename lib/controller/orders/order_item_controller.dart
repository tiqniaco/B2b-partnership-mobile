import 'dart:io';

import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/shop_product_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class OrderItemController extends GetxController {
  late ShopProductModel product;

  @override
  void onInit() {
    product = Get.arguments['product'] as ShopProductModel;
    super.onInit();
  }

  Future<void> download() async {
    // if (true) {
    Directory? downloadsDirectory;
    if (Platform.isAndroid) {
      downloadsDirectory = Directory('/storage/emulated/0/Download');
    } else {
      downloadsDirectory = await getApplicationDocumentsDirectory();
    }

    String filePath =
        '${downloadsDirectory.path}/${product.file.split('/').last}';

    logger.d(filePath);

    final response = await Dio().download(
      product.file,
      filePath,
    );
    if (response.statusCode == 200) {
      logger.i(response.statusMessage);
      AppSnackBars.success(message: 'File downloaded successfully');
    }
    // }
    //  else {}
  }
}
