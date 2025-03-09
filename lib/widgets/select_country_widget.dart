import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectCountryWidget extends StatelessWidget {
  const SelectCountryWidget({
    super.key,
    required this.enabled,
    required this.value,
    required this.models,
    required this.onChanged,
  });

  final bool enabled;
  final CountryModel value;
  final List<CountryModel> models;
  final void Function(CountryModel?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CountryModel>(
        isExpanded: true,
        value: value,
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
          label: Text(
            'Select Country',
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
        items: models.map((item) {
          return DropdownMenuItem<CountryModel>(
            value: item,
            child: Row(
              children: [
                Text(
                  item.flag!,
                  style: getMediumStyle,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    translateDatabase(
                        arabic: item.nameAr!, english: item.nameEn!),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: greyColor.withAlpha(160),
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged);
  }
}
