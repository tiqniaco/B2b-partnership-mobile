import 'package:b2b_partenership/controller/see_all/see_all_controller.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/home/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SeeAll extends StatelessWidget {
  const SeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SeeAllController());
    return GetBuilder<SeeAllController>(
      builder: (controller) => Scaffold(
          appBar: AppBar(
            toolbarHeight: context.isTablet ? 45.h : null,
            backgroundColor: whiteColor,
            title: Text(
              controller.title,
              style: getMediumStyle(context),
            ),
          ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.isTablet ? 3 : 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: context.isTablet ? 6 / 9 : 6 / 10.5),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemCount: controller.providers.length,
            itemBuilder: (context, index) => ProviderWidget(
                provider: controller.providers[index],
                toggleFavorite: () {
                  controller.toggleFavorites(
                      controller.providers[index].providerId.toString());
                }),
          )),
    );
  }
}
