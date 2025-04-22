import 'dart:io';

import 'package:b2b_partenership/controller/previous_work/edit_previous_work_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditPreviousWorkView extends StatelessWidget {
  const EditPreviousWorkView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditPreviousWorkController>(
      init: EditPreviousWorkController(),
      builder: (EditPreviousWorkController controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Previous Work'.tr),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          controller.pickedImage.isEmpty
                              ? CustomNetworkImage(
                                  imageUrl: controller.model.image!)
                              : Image.file(
                                  File(controller.pickedImage),
                                ),
                          PositionedDirectional(
                            top: 10,
                            end: 10,
                            child: InkWell(
                              onTap: () {
                                controller.pickImage();
                              },
                              child: CircleAvatar(
                                backgroundColor: whiteColor,
                                radius: 20.r,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: blackColor,
                                  size: 20.r,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(20.h),
                    TextFormField(
                      controller: controller.titleController,
                      decoration: InputDecoration(labelText: 'Work Title'.tr),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: controller.descriptionController,
                      decoration: InputDecoration(labelText: 'Description'.tr),
                      maxLines: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    CustomLoadingButton(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          return controller.editPreviousWork();
                        }
                      },
                      text: 'Update'.tr,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
