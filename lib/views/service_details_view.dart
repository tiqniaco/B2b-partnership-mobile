// ignore_for_file: deprecated_member_use

import 'package:b2b_partenership/controller/service_details_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/services/date_time_convertor.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/widgets/service_details.dart/feature_widget.dart';
import 'package:b2b_partenership/widgets/service_details.dart/seller_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ServiceDetailsView extends StatelessWidget {
  ServiceDetailsView({super.key});
  final controller = Get.put(ServiceDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(color: borderColor),
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 63,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.contactMethods();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text('Book Appointment'),
                  ),
                ),
              ),
              Gap(10),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    color: Colors.black54,
                    Icons.chat_outlined,
                    size: 35.sp,
                  ))
            ],
          ),
        ),
      ),
      body: GetBuilder<ServiceDetailsController>(builder: (controller) {
        return controller.service == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          width: double.infinity,
                          height: 265.h,
                          fit: BoxFit.cover,
                          imageUrl: controller.service!.data!.image!,
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/default.jpg', // ضع رابط الصورة هنا
                            width: double.infinity,
                            height: 265.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 265.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 16,
                          child: IconButton(
                            icon:
                                Icon(Icons.arrow_back_ios, color: Colors.white),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                        Positioned(
                          top: 60,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              "Service List",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(10),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 17, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                              ),
                              child: Text(
                                'Watch Video',
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(height: 13),
                          Text(
                            translateDatabase(
                                arabic: controller.service!.data!.nameAr!,
                                english: controller.service!.data!.nameEn!),
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 17.sp,
                                backgroundColor: Colors.grey[200],
                                backgroundImage: CachedNetworkImageProvider(
                                    controller.service!.provider!.image!),
                              ),
                              SizedBox(width: 10),
                              Text(controller.service!.provider!.name!),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Our Package',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                // Text(
                                //   '\$${controller.service!.data!.price!}',
                                //   style: TextStyle(
                                //     letterSpacing: 2,
                                //     color: primaryColor,
                                //     fontSize: 15.sp,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                          FeatureWidget(),
                          Gap(20),
                          FractionallySizedBox(
                            widthFactor: 10,
                            child: Divider(
                              color: borderColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      DateTimeConvertor.timeAgo(controller
                                              .service!.data!.createdAt!)
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Gap(7),
                                    Text(
                                      'Date',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: greyColor,
                                  height: 10.h,
                                  width: 1,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      controller.service!.data!.rating!,
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Gap(3),
                                    Icon(
                                      Icons.circle,
                                      size: 3.sp,
                                      color: greyColor,
                                    ),
                                    Gap(3),
                                    Icon(
                                      Icons.star,
                                      size: 15.sp,
                                      color: Colors.orange,
                                    ),
                                    Gap(7),
                                    Text(
                                      'Service Ratings',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 10,
                            child: Divider(
                              color: borderColor,
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    controller.ontapOverView();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                          width: 5,
                                          color: controller.isOverView
                                              ? primaryColor
                                              : Colors.white),
                                    )),
                                    child: Text(
                                      "Overview".tr,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: controller.isOverView
                                            ? primaryColor
                                            : blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    controller.ontapSaller();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 3,
                                                color: controller.isSaller
                                                    ? primaryColor
                                                    : Colors.white))),
                                    child: Text(
                                      "About Seller".tr,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: controller.isSaller
                                            ? primaryColor
                                            : blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            
                          Divider(
                            height: 0,
                            color: const Color.fromARGB(255, 198, 137, 139),
                          ),
                          Gap(5),
                          controller.isOverView
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    controller.service!.data!.overview!,
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              : controller.isSaller
                                  ? SellerWidget()
                                  
                                      
                                      : SizedBox.shrink(),
                        ],
                      ),
                    
                  ],
                      ))])
              );
      }),
    );
  }
}
