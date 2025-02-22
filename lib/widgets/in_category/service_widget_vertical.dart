import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/models/services_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ServiceWidgetVertical extends StatelessWidget {
  const ServiceWidgetVertical({
    super.key,
    required this.services,
  });
  final List<ServiceModelData> services;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 5),
        itemCount: services.length,
        separatorBuilder: (context, index) => Gap(20),
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.serviceDetails,
                    arguments: {"id": services[index].id});
              },
              child: Container(
                height: 116.h,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withAlpha(80))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: services[index].image!,
                            height: 70.h,
                            width: 75.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                services[index].description!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Gap(10),
                              Row(
                                children: [
                                  Text(
                                    translateDatabase(
                                        arabic: services[index]
                                            .specializationNameAr!,
                                        english: services[index]
                                            .specializationNameEn!),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: greyColor,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: 100,
                                    height: 26.h,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            padding: WidgetStatePropertyAll(
                                                EdgeInsets.symmetric(
                                                    horizontal: 10)),
                                            shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)))),
                                        onPressed: () {},
                                        child: Text(
                                          "View Details",
                                          style: TextStyle(fontSize: 11.sp),
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
