import 'package:b2b_partenership/controller/previous_work/previous_work_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkImage extends StatelessWidget {
  const WorkImage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Get.put(PreviousDetailsWorkController());
    return GetBuilder<PreviousDetailsWorkController>(
      builder: (controller) {
        return ListView.builder(
          itemCount: controller.images.length,
          itemBuilder: (context, index) => Container(),
        );
      },
    );
  }
}
