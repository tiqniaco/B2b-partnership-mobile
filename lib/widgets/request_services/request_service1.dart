import 'package:b2b_partenership/controller/request_services/request_service_controller.dart';
import 'package:b2b_partenership/widgets/request_services/build_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RequestService1 extends StatelessWidget {
  const RequestService1({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestServiceController>(builder: (controller) {
      return Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: controller.galleryImage,
              child: controller.imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.file(controller.imageFile!,
                          height: 130.h, width: 180.h, fit: BoxFit.cover),
                    )
                  : Container(
                      height: 130.h,
                      width: 180.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(Icons.image,
                          size: 50, color: Colors.grey.shade700),
                    ),
            ),
          ),
          Gap(10),
          Text("upload service image (optional)"),
          Gap(40),
          buildTextField(controller.titleArController, 'Title (Arabic)',
              Icons.title, "enter title in arabic"),
          Gap(30),
          buildTextField(controller.titleEnController, 'Title (English)',
              Icons.title, "enter title in english"),
          Gap(30),
          buildTextField(controller.addressController, 'Address',
              Icons.location_on, "enter your address"),
          Gap(30),
          buildTextField(controller.descriptionController, 'Description',
              Icons.description, "enter service description"),
          Gap(20),
        ],
      );
    });
  }
}
