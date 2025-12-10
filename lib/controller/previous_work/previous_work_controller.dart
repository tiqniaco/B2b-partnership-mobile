// ignore_for_file: avoid_print, prefer_final_fields

import 'dart:io';

import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/core/utils/assets_data.dart';
import 'package:b2b_partenership/models/pervious_work_model.dart';
import 'package:b2b_partenership/models/previous_work_image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:widget_zoom/widget_zoom.dart';

class PreviousDetailsWorkController extends GetxController {
  int currentPage = 0;
  late ProviderPerviousWorkModel model;
  List<PreviousImagesModel> images = [];
  StatusRequest statusRequest = StatusRequest.loading;
  // String pickedImage = '';
  List<String> pickedImages = [];
  ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    model = Get.arguments['model'];
    getImages();
    super.onInit();
  }

  Future<void> getImages() async {
    statusRequest = StatusRequest.loading;
    update();
    final result = await CustomRequest(
      path: ApiConstance.getWorkImages,
      queryParameters: {"provider_previous_work_id": model.id},
      fromJson: (json) {
        return json['images']
            .map<PreviousImagesModel>(
                (type) => PreviousImagesModel.fromJson(type))
            .toList();
      },
    ).sendGetRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      images = r;
      if (images.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
      update();
    });
  }

  changeSlider(int index) {
    print(index);
    currentPage = index;
    update(["slider"]);
  }

  pickImage() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      for (var image in images) {
        if (!pickedImages.any((pickedImage) =>
            pickedImage.split('/').last == image.path.split('/').last)) {
          pickedImages.add(image.path);
        }
      }
      update();
    }
  }

  Future<void> uploadImages() async {
    final result = await CustomRequest<String>(
      path: ApiConstance.addProviderPreviousWorkImage,
      files: {
        for (int i = 0; i < pickedImages.length; i++)
          'images[$i]': pickedImages[i],
      },
      data: {
        'provider_previous_work_id': model.id.toString(),
      },
      fromJson: (json) {
        return json['message'];
      },
    ).sendPostRequest();

    result.fold(
      (error) {
        update();
        AppSnackBars.error(message: error.errMsg);
      },
      (data) {
        Get.back();
        AppSnackBars.success(message: data);
        getImages();
      },
    );
  }

  Future<void> deletePreviousWorkImage(int index) async {
    await Get.defaultDialog<bool>(
      title: 'Delete Image'.tr,
      middleText: 'Are you sure you want to delete this image?'.tr,
      textConfirm: 'Yes'.tr,
      textCancel: 'No'.tr,
      onConfirm: () async {
        Get.back();
        final id = images[index].id;
        images[index].isDeleteLoading = true;
        update();
        final response = await CustomRequest<String>(
          path: ApiConstance.deleteProviderPreviousWorkImage(id.toString()),
          fromJson: (json) {
            return json['message'];
          },
        ).sendDeleteRequest();
        response.fold(
          (error) {
            AppSnackBars.error(message: error.errMsg);
            images[index].isDeleteLoading = false;
            update();
          },
          (data) {
            AppSnackBars.success(message: data);
            images.removeWhere((element) => element.id == id);
            update();
          },
        );
      },
    );
  }

  Future<void> addPreviousWorkImageDialog() async {
    pickedImages.clear();
    await Get.defaultDialog(
      title: "Add Image".tr,
      content: GetBuilder<PreviousDetailsWorkController>(
        builder: (logic) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Column(
              children: [
                Text(
                  "Select images to upload".tr,
                  style: getRegularStyle(Get.context!),
                ),
                Gap(10.h),
                if (pickedImages.isNotEmpty)
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: [
                      for (var image in pickedImages)
                        Stack(
                          children: [
                            WidgetZoom(
                              heroAnimationTag: image,
                              zoomWidget: Container(
                                height: 60.h,
                                width: 60.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: FileImage(File(image)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  pickedImages.remove(image);
                                  update();
                                },
                                child: Container(
                                  height: 20.h,
                                  // width: 20.w,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(2.r),
                                  child: Icon(
                                    Icons.close,
                                    size: 15.r,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                          height: 50.h,
                          width: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[300],
                          ),
                          child: Icon(
                            Icons.add,
                            size: 30.r,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Image.asset(
                    AssetsData.defaultImage,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                TextButton.icon(
                  onPressed: () {
                    pickImage();
                  },
                  icon: Icon(Icons.image),
                  label: Text(
                    "Select from Gallery".tr,
                    style: getRegularStyle(Get.context!),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      confirm: CustomLoadingButton(
        onPressed: () {
          return uploadImages();
        },
        text: "Upload".tr,
      ),
    );
  }
}
