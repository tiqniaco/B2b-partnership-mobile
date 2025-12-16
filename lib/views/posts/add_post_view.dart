import 'package:b2b_partenership/controller/posts/add_post_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/posts/post_widget_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';


class AddPostView extends StatelessWidget {
  AddPostView({super.key});
  final controller = Get.put(AddPostController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            toolbarHeight: context.isTablet ? 45.h : null,
            title: Text(
              'Add Service'.tr,
              style: getSemiBoldStyle(context).copyWith(
                color: blackColor,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: controller.formKey,
                    child: const PostWidget1(),
                  ),
                  CustomLoadingButton(
                      borderRadius: 12.r,
                      onPressed: () {
                        return controller.addServices();
                      },
                      text: 'Add'.tr),
                  Gap(300)
                ],
              ),
            ),
          ));
    });
  }
}
