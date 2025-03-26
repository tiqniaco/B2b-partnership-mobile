import 'package:b2b_partenership/models/shop_category_model.dart';
import 'package:get/get.dart';

class AllCategoriesController extends GetxController {
  late List<ShopCategoryModel> shopCategories;
  @override
  void onInit() {
    shopCategories = Get.arguments["categories"];
    super.onInit();
  }
}
