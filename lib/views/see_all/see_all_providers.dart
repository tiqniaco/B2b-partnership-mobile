import 'package:b2b_partenership/controller/see_all/see_all_controller.dart';
import 'package:b2b_partenership/core/services/responsive_helper.dart';
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
            title: Text(
              "Top Rated Providers".tr,
              style: getMediumStyle(context),
            ),
          ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    context.isTablet ? 3 : 2, //getCrossAxisCount(context),
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: ResponsiveHelper.getValue(
                    thinValue: 0.63, // 393
                    extraSmallValue: 0.69, // 450
                    smallValue: 0.82, // 600
                    mediumValue: 0.89, // 900
                    largeValue: 1.2, // 1200
                    extraLargeValue: 1.5)),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 60),
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
