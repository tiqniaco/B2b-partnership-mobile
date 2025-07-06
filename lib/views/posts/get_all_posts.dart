import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/functions/please_login_dialog.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';

import 'package:b2b_partenership/widgets/posts/freelance_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../controller/posts/get_all_posts_controller.dart';

class GetAllPosts extends StatelessWidget {
  GetAllPosts({super.key});
  final controller = Get.put(AllPostsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AllPostsController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.searchController,
                        style: getRegularStyle(context),
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: () {
                              if (controller.searchController.text.isNotEmpty) {
                                controller.getServices();
                              } else {
                                controller.getServices();
                              }
                            },
                            icon: Icon(
                              CupertinoIcons.search,
                              size: context.isTablet ? 13.w : 18.w,
                              color: primaryColor,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          hintText: 'Search'.tr,
                          hintStyle: getMediumStyle(context)
                              .copyWith(fontSize: 14.r, color: primaryColor),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            controller.getServices();
                          }
                        },
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            controller.getServices();
                          } else {
                            controller.getServices();
                          }
                        },
                      ),
                    ),
                    Gap(20),
                    InkWell(
                      onTap: () {
                        return controller.showFilterDialog();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: customBorderRadius,
                        ),
                        child: Icon(
                          FontAwesomeIcons.sliders,
                          color: whiteColor,
                          size: 18.r,
                        ),
                      ),
                    ),
                    Gap(10),
                    InkWell(
                      onTap: () {
                        Get.find<AppPreferences>().getToken() == ''
                            ? pleaseLoginDialog()
                            : Get.toNamed(AppRoutes.getRequestServices);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: context.isTablet ? 120 : null,
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: customBorderRadius,
                          ),
                          child: Text(
                            "My Posts".tr,
                            style: getMediumStyle(context).copyWith(
                              fontSize: 12.r,
                              fontWeight: FontWeight.bold,
                              color: whiteColor,
                            ),
                          )),
                    ),
                  ],
                ),
                Gap(24),
                Expanded(
                  child: CustomServerStatusWidget(
                    statusRequest: controller.statusRequest,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Gap(20),
                      scrollDirection: Axis.vertical,
                      itemCount: controller.services.length,
                      itemBuilder: (context, index) => FreelanceItem(
                        model: controller.services[index],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
