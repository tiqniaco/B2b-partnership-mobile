import 'package:b2b_partenership/controller/search/search_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/home/provider_widget.dart';
import 'package:b2b_partenership/widgets/search/select_city_filter.dart';
import 'package:b2b_partenership/widgets/search/select_country_filter.dart';
import 'package:b2b_partenership/widgets/search/select_specialization_filter.dart';
import 'package:b2b_partenership/widgets/search/select_sup_specialization_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchControllerIM());
    return GetBuilder<SearchControllerIM>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leadingWidth: 50,
          toolbarHeight: context.isTablet ? 45.h : null,
          title: TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 8.h,
              ),
              hintStyle: getRegularStyle(context),
              hintText: "Search ...".tr,
              suffixIcon: InkWell(
                onTap: () {
                  controller.search();
                },
                child: Icon(
                  Icons.search,
                  color: greyColor,
                  size: context.isTablet ? 13.w : 20.w,
                ),
              ),
            ),
          ),
        ),
        body: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(15),
                    SizedBox(
                      height: 32.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          customWidget(
                            Icons.star_border_rounded,
                            "Rating".tr,
                            () {
                              showRatingSheet(context);
                            },
                          ),
                          customWidget(
                              Icons.location_on_outlined, "Location".tr, () {
                            showLocationSheet(context);
                          }),
                          customWidget(Icons.category_outlined, "Category".tr,
                              () {
                            showCategorySheet(context);
                          }),
                          customWidget(
                            CupertinoIcons.refresh_thin,
                            "Reset".tr,
                            () {
                              controller.resetFunction();
                            },
                            arrowIcon: Icons.refresh,
                          )
                        ],
                      ),
                    ),
                    Gap(10),
                    controller.isSearch
                        ? Text(
                            "${controller.searchList.length} ${"Provider".tr}",
                            style: getRegularStyle(context),
                          )
                        : Text(
                            "${controller.topProviders.length} ${"Provider".tr}",
                            style: getRegularStyle(context),
                          ),
                    Gap(10),
                  ],
                ),
              ),
              Expanded(
                  child: CustomServerStatusWidget(
                statusRequest: controller.isSearch
                    ? controller.statusRequestSearch
                    : controller.statusRequestProviders,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.isTablet ? 3 : 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      childAspectRatio: context.isTablet ? 0.69 : 6 / 8.2,
                    ),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    itemCount: controller.isSearch
                        ? controller.searchList.length
                        : controller.topProviders.length,
                    itemBuilder: (context, index) => ProviderWidget(
                        provider: controller.isSearch
                            ? controller.searchList[index]
                            : controller.topProviders[index],
                        toggleFavorite: () {
                          controller.toggleFavorites(controller
                              .searchList[index].providerId
                              .toString());
                        })),
              )),
              Gap(50),
            ],
          ),
        ),
      );
    });
  }

  Widget customWidget(
    IconData icon,
    String title,
    Function() onTap, {
    bool isShowArrow = false,
    IconData? arrowIcon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        margin: EdgeInsetsDirectional.only(
          end: Get.context!.isTablet ? 5.w : 8.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: greyColor.withAlpha(150),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: getLightStyle(Get.context!).copyWith(
                color: blackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(5),
            Icon(
              arrowIcon ?? Icons.keyboard_arrow_down_outlined,
              color: blackColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonWidget(String title, Function() onTap, bool active) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 9.h),
        decoration: BoxDecoration(
            color: active ? primaryColor : Colors.transparent,
            border: Border.all(color: greyColor),
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          title.tr,
          style: getRegularStyle(Get.context!).copyWith(
            fontWeight: FontWeight.normal,
            // fontSize: 13.sp,
            color: active ? whiteColor : blackColor,
          ),
        ),
      ),
    );
  }

  showRatingSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => GetBuilder<SearchControllerIM>(
        id: "rating",
        builder: (ratingController) {
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 1),
                color: borderColor.withAlpha(20),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: SizedBox(
                    width: 40.w,
                    child: Divider(
                      thickness: 4,
                      color: greyColor,
                    ),
                  ),
                ),
                Gap(6.h),
                Text(
                  "Rating Filter:".tr,
                  style: getMediumStyle(context),
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      //ignoreGestures: true,
                      itemSize: context.isTablet ? 20.w : 25.w,
                      initialRating: ratingController.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        ratingController.onTapRating(rating);
                      },
                    ),
                    Gap(20),
                    IconButton(
                        onPressed: () {
                          ratingController.resetRating();
                        },
                        icon: Icon(
                          CupertinoIcons.refresh,
                          color: greyColor,
                          size: 25.sp,
                        ))
                  ],
                ),
                Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: buttonWidget("Clear Filter", () {
                          ratingController.resetRating();
                        }, false),
                      ),
                      Gap(20),
                      Expanded(
                        child: buttonWidget("Apply Filter", () {
                          ratingController.search();
                        }, true),
                      )
                    ],
                  ),
                ),
                Gap(50)
              ],
            ),
          );
        },
      ),
    );
  }

  showLocationSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => GetBuilder<SearchControllerIM>(
        id: "location",
        builder: (locationController) {
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 1),
                color: borderColor.withAlpha(20),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: SizedBox(
                    width: 40.w,
                    child: Divider(
                      thickness: 4,
                      color: greyColor,
                    ),
                  ),
                ),
                Gap(6),
                Text(
                  "Location Filter:".tr,
                  style: getMediumStyle(context),
                ),
                Gap(30),
                SelectCountryFilter(
                  enabled: false,
                ),
                Gap(30),
                SelectCityFilter(),
                Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: buttonWidget("Clear Filter", () {
                          locationController.resetLocation();
                        }, false),
                      ),
                      Gap(20),
                      Expanded(
                        child: buttonWidget("Apply Filter", () {
                          locationController.search();
                        }, true),
                      )
                    ],
                  ),
                ),
                Gap(50)
              ],
            ),
          );
        },
      ),
    );
  }

  showCategorySheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => GetBuilder<SearchControllerIM>(
        id: "category",
        builder: (categoryController) {
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 1),
                color: borderColor.withAlpha(20),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: SizedBox(
                    width: 40.w,
                    child: Divider(
                      thickness: 4,
                      color: greyColor,
                    ),
                  ),
                ),
                Gap(6),
                Text(
                  "Category Filter:".tr,
                  style: getMediumStyle(context),
                ),
                Gap(30.h),
                SelectSpecializationFilter(),
                Gap(30.h),
                SelectSupSpecializationFilter(),
                Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: buttonWidget("Clear Filter", () {
                          categoryController.resetCategory();
                        }, false),
                      ),
                      Gap(20),
                      Expanded(
                        child: buttonWidget("Apply Filter", () {
                          categoryController.search();
                        }, true),
                      )
                    ],
                  ),
                ),
                Gap(50)
              ],
            ),
          );
        },
      ),
    );
  }
}
