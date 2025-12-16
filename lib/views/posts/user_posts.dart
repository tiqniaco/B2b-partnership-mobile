import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/posts/user_posts_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_error_widget.dart';
import 'package:b2b_partenership/core/global/widgets/custom_no_connection_widget.dart';
import 'package:b2b_partenership/core/global/widgets/global_server_status_widget.dart';
import 'package:b2b_partenership/core/global/widgets/place_holder.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/please_login_widget.dart';
import 'package:b2b_partenership/widgets/posts/freelance_item.dart';
import 'package:b2b_partenership/widgets/posts/post_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class UserPostsView extends StatelessWidget {
  const UserPostsView({super.key});
  @override
  Widget build(BuildContext context) {
    if (ApiConstance.token.isEmpty) {
      return const PleaseLoginWidget();
    }
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        // backgroundColor: whiteColor,
        toolbarHeight: context.isTablet ? 50.h : null,
        title: Text(
          'My Posts'.tr,
          style: getSemiBoldStyle(context).copyWith(
            fontWeight: FontWeight.bold,
            color: blackColor,
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 50.w,
        height: 50.h,
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoutes.addServicesRequest);
          },
          shape: CircleBorder(),
          child: Icon(
            Icons.add,
            size: 25.r,
          ),
        ),
      ),
      body: GetBuilder<UserPostsController>(
        init: UserPostsController(),
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10),
            GlobalServerStatusWidget(
              statusRequest: controller.statusRequest,
              loadingChild: Expanded(child: PostLoadingWidget()),
              errorChild: CustomErrorWidget(),
              noConnectionChild: CustomNoConnectionWidget(
                onTap: () {
                  controller.getServices();
                },
              ),
              noDataChild: PlaceHolderWidget(
                icon: Image.asset("assets/images/no_posts.png"),
                title: 'No Posts Now'.tr,
                subTitle: 'Try again later or add new post'.tr,
              ),
              successChild: Expanded(
                  child: ListView.separated(
                separatorBuilder: (context, index) => Gap(15),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemCount: controller.services.length,
                itemBuilder: (context, index) => FreelanceItem(
                  model: controller.services[index],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
