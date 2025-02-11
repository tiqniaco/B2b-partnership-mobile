import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/models/services_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ServiceWidgetHorizontal extends StatelessWidget {
  const ServiceWidgetHorizontal({
    super.key,
    required this.services,
  });
  final List<ServiceModelData> services;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: services.length,
        separatorBuilder: (context, index) => Gap(20),
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.serviceDetails,
                    arguments: {"id": services[index].id.toString()});
              },
              child: Container(
                width: 250.h,
                height: 103.h,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withAlpha(80))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 80.h,
                          child: Stack(
                            alignment: Alignment.topCenter,
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
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          width: 2, color: whiteColor),
                                      color: Colors.amber),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star_border_purple500_sharp,
                                        size: 14.sp,
                                      ),
                                      Gap(6),
                                      Text(services[index].rating!)
                                    ],
                                  ),
                                ),
                              )
                            ],
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
                                // translateDatabase(
                                //   arabic: services[index].nameAr!,
                                //   english: services[index].nameEn!,
                                // ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Gap(10),
                              Row(
                                children: [
                                  Text(
                                    " by:  ",
                                    style: TextStyle(color: greyColor),
                                  ),
                                  Text(
                                    "text saller",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: greyColor,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Gap(10),
                    Divider(),
                    Gap(10),
                    Row(
                      children: [
                        Text(
                          "\$30",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.grey[200]!)),
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.bookmarks_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Gap(15),
                            SizedBox(
                              width: 110,
                              height: 36.h,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Book Now",
                                    style: TextStyle(fontSize: 11.sp),
                                  )),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
