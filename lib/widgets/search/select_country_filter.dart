import 'package:b2b_partenership/controller/search/search_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/models/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectCountryFilter extends StatelessWidget {
  const SelectCountryFilter({
    super.key,
    required this.enabled,
  });

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControllerIM>(
      builder: (controller) => DropdownButtonFormField<CountryModel>(
        // value: controller.selectedCountry,
        isExpanded: true,
        decoration: InputDecoration(
          enabled: enabled,
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
          hintText: "All Countries".tr,
          label: Text(
            'Select Country'.tr,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.sp,
                color: Colors.black87),
          ),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 23.sp,
          color: greyColor,
        ),
        items: controller.countries.map((item) {
          return DropdownMenuItem<CountryModel>(
            value: item,
            child: Row(
              children: [
                Text(
                  item.flag!,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: greyColor.withAlpha(160),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
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
          controller.onCountryChanged(value);
        },
      ),
    );
  }
}
