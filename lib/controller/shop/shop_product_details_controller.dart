import 'package:b2b_partenership/controller/shop/shop_cart_controller.dart';
import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/functions/please_login_dialog.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/product_description_model.dart';
import 'package:b2b_partenership/models/shop_product_model.dart';
import 'package:get/get.dart';

class ShopProductDetailsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  ShopProductModel? product;
  String productId = "";
  List<ProductDescriptionModel> descriptions = [];

  List<String> items = [
    "First step",
    "Second step",
    "Third step",
    "Fourth step"
  ];

  @override
  void onInit() {
    // product = Get.arguments['product'] as ShopProductModel;
    productId = Get.arguments?['productId'] as String;
    getProductDetails();

    super.onInit();
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
        product = ShopProductModel.fromJson(data['data']);
        descriptions = List<ProductDescriptionModel>.from(
          data['descriptions'].map(
            (e) => ProductDescriptionModel.fromJson(e),
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
    print("hi call back $index");
    isExpanded == !isExpanded;
    update();
  }
}
