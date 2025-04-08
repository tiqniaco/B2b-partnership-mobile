// ignore_for_file: deprecated_member_use

import 'package:b2b_partenership/controller/save/saved_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/home/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SaveView extends StatelessWidget {
  const SaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.isTablet ? 45.h : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        iconTheme: IconThemeData(color: whiteColor),
        backgroundColor: primaryColor,
        title: Text(
          "Saved".tr,
          style: getMediumStyle(context).copyWith(
            color: whiteColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: GetBuilder<SavedController>(
          init: SavedController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 5, left: 10, right: 10),
                  child: Row(
                    children: [
                      Text(
                        controller.favorites.length.toString(),
                        style: getMediumStyle(context).copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(10),
                      Text(
                        "Saved Provider".tr,
                        style: getMediumStyle(context).copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Gap(10),
                Expanded(
                  child: CustomServerStatusWidget(
                    statusRequest: controller.statusRequestProviders,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: context.isTablet ? 3 : 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 10,
                          childAspectRatio:
                              context.isTablet ? 6 / 9 : 6 / 10.5),
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      itemCount: controller.favorites.length,
                      itemBuilder: (context, index) => ProviderWidget(
                          provider: controller.favorites[index],
                          toggleFavorite: () {
                            controller.onTapFavorite(controller
                                .favorites[index].providerId
                                .toString());
                          }),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
