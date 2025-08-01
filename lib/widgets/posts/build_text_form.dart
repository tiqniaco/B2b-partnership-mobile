import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildTextField(
  TextEditingController controller,
  String label,
  IconData icon,
  String hintText,
  String Function(String?) validator, {
  bool hasValidation = true,
  double? labelWidth,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
        hintText: hintText,
        hintStyle: getRegularStyle(Get.context!).copyWith(color: blackColor),
        filled: true,
        fillColor: whiteColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: greyColor, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      maxLines: null,
      validator: hasValidation
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            }
          : null,
    ),
  );
}
