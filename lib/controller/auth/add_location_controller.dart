// ignore_for_file: avoid_print


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums/status_request.dart';


class AddLocationController extends GetxController {
  late TextEditingController streetController;
  late TextEditingController buildingNumController;
  late TextEditingController floorNumController;
  late TextEditingController flatNumController;
  late TextEditingController addressController;
  late TextEditingController spacailMarkController;
  late String token;
  //final _authRepo = Get.find<AuthRepo>();

  StatusRequest? statusRequest;
  

  GlobalKey<FormState> formKeyLocation = GlobalKey<FormState>();

  late String fromPage;

  @override
  Future<void> onInit() async {
    fromPage = Get.arguments['fromPage'];
    token = Get.arguments['token'];
    addressController = TextEditingController();
    spacailMarkController = TextEditingController();
    streetController = TextEditingController();
    buildingNumController = TextEditingController();
    flatNumController = TextEditingController();
    floorNumController = TextEditingController();
   // await getRegions();
    // getCurrentLocation();
    super.onInit();
  }

  // onChangedRegion(Region? value) async {
  //   selectedRegion = value;
  //   print(selectedRegion);
  //   update();
  // }

  validUserData(val) {
    if (val.isEmpty) {
      return "can't be empty";
    }
  }

  // Future<void> getRegions() async {
  //   // statusRequestItem = StatusRequest.loading;
  //   //.clear();
  //   update();

  //   final result = await _authRepo.getRegions();
  //   result.fold(
  //     (error) {
  //       statusRequest = StatusRequest.error;
  //       update();
  //     },
  //     (data) {
  //       if (data.isEmpty) {
  //         statusRequest = StatusRequest.noData;
  //       } else {
  //         regions.clear();
  //         regions = data;
  //         statusRequest = StatusRequest.success;
  //       }

  //       update();
  //     },
  //   );
  // }

  // Future<void> addLocation() async {
  //   if (selectedRegion == null) {
  //     AppSnackBars.warning(message: "please select your region".tr);
  //   } else {
  //     if (formKeyLocation.currentState!.validate()) {
  //       formKeyLocation.currentState!.save();
  //       update();
  //       Map data = {
  //         "region_id": selectedRegion!.id,
  //         "url": addressController.text,
  //         "street": streetController.text,
  //         "building_number": buildingNumController.text,
  //         "special_mark": spacailMarkController.text,
  //         "floor_number": floorNumController.text,
  //         "flat_number": flatNumController.text,
  //       };
  //       final result = await _authRepo.addLocation(data, token);
  //       result.fold(
  //         (error) {
  //           AppSnackBars.error(message: error.errMsg);
  //           //isLoading = false;
  //           update();
  //         },
  //         (data) {
  //           //isLoading = false;
  //           update();
  //           log(data.toString(), name: "add location response");
  //           AppSnackBars.success(message: "location added successfully".tr);
  //           spacailMarkController.clear();
  //           streetController.clear();
  //           buildingNumController.clear();
  //           floorNumController.clear();
  //           flatNumController.clear();
  //           addressController.clear();
  //           selectedRegion = null;
  //           if (fromPage == "signup") {
  //             if (Get.find<AppPreferences>().getUserRole() == "laundry") {
  //               Get.defaultDialog(
  //                 title: "Success".tr,
  //                 content: Text(
  //                   "Your signup request sent, please wait admin approval, we will sent notification to you"
  //                       .tr,
  //                 ),
  //               );
  //               // Get.offAllNamed(AppRoutes);
  //               subscribeTopics(
  //                 int.parse(
  //                   Get.find<AppPreferences>().getUserId(),
  //                 ),
  //               );
  //             }
  //             Get.toNamed(AppRoutes.login);
  //           } else {
  //             CartController controller = Get.put(CartController());
  //             Get.back();
  //             controller.getLocations();
  //           }
  //         },
  //       );
  //     } else {
  //       debugPrint("invalid");
  //     }
  //   }
  // }

  @override
  void dispose() {
    addressController.dispose();
    spacailMarkController.dispose();
    streetController.dispose();
    buildingNumController.dispose();
    floorNumController.dispose();
    flatNumController.dispose();
    super.dispose();
  }
}
