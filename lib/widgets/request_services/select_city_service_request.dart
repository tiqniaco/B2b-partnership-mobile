import 'package:b2b_partenership/controller/request_services/request_service_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/models/city_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SelectCityServiceRequest extends StatelessWidget {
  const SelectCityServiceRequest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestServiceController>(
      builder: (controller) => DropdownButtonFormField<CityModel>(
        value: controller.selectedCity, //CountryModel
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.r),
            borderSide: const BorderSide(color: blackColor, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: pageColor, width: 1.5),
          ),
          label: Column(
            children: [
              Container(
                width: 210,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "Select City",
                  style:
                      TextStyle(color: whiteColor, fontWeight: FontWeight.w500),
                ),
              ),
              Gap(35)
            ],
          ),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 23.sp,
          color: greyColor,
        ),
        items: controller.cities.map((item) {
          return DropdownMenuItem<CityModel>(
            value: item,
            child: Row(
              children: [
                Text(
                  translateDatabase(
                      arabic: item.nameAr!, english: item.nameEn!),
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: greyColor.withAlpha(160),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          controller.onCityChanged(value);
        },
      ),
    );
  }
}
