import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/provider_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectProviderWidget extends StatelessWidget {
  const SelectProviderWidget({
    super.key,
    required this.onChanged,
    required this.value,
    required this.providerTypes,
  });

  final void Function(ProviderTypeModel?)? onChanged;
  final ProviderTypeModel? value;
  final List<ProviderTypeModel> providerTypes;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ProviderTypeModel>(
      value: value,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: const BorderSide(color: blackColor, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(color: pageColor, width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white,
        label: Text(
          'Provider Type'.tr,
          style: getMediumStyle(context)
              .copyWith(fontWeight: FontWeight.w500, color: Colors.black87),
        ),
      ),
      icon: Icon(
        Icons.keyboard_arrow_down_outlined,
        size: 23.r,
        color: greyColor,
      ),
      items: providerTypes.map((item) {
        return DropdownMenuItem<ProviderTypeModel>(
          value: item,
          child: Row(
            children: [
              Text(
                translateDatabase(
                    arabic: item.nameAr ?? "", english: item.nameEn ?? ""),
                style: getLightStyle(context).copyWith(
                  color: blackColor,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
