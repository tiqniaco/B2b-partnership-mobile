import 'package:b2b_partenership/controller/search/search_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
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
          contentPadding: EdgeInsets.symmetric(
            vertical: context.isTablet ? 8.h : 10.h,
            horizontal: 12.w,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.r),
            borderSide: const BorderSide(color: blackColor, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: pageColor, width: 1.5),
          ),
          hintText: "All Countries".tr,
          hintStyle: getMediumStyle(context).copyWith(
            fontWeight: FontWeight.w500,
            color: hintColor,
          ),
          label: Text(
            'Select Country'.tr,
            style: getMediumStyle(context).copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 23.r,
          color: greyColor,
        ),
        items: controller.countries.map((item) {
          return DropdownMenuItem<CountryModel>(
            value: item,
            child: Row(
              children: [
                Text(
                  item.flag!,
                  style: getMediumStyle(context).copyWith(
                      color: greyColor.withAlpha(160),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Text(
                  translateDatabase(
                      arabic: item.nameAr!, english: item.nameEn!),
                  style: getMediumStyle(context).copyWith(
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
