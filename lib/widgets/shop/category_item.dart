import 'package:b2b_partenership/controller/shop/shop_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/shop_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CategoryItem extends GetView<ShopController> {
  const CategoryItem(this.index, {super.key, required this.model});
  final ShopCategoryModel model;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.onTapCategory(index);
      },
      child: SizedBox(
        width: 142.w,
        height: 84.h,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.r),
                    topRight: Radius.circular(10.r),
                  ),
                  child: CustomNetworkImage(
                    imageUrl: model.image,
                    width: 140.w,
                    height: 84.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Gap(8),
                Text(
                  translateDatabase(
                    arabic: model.nameAr,
                    english: model.nameEn,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getRegularStyle(context).copyWith(
                      fontWeight: FontWeight.w400,
                      color: blackColor,
                      fontSize: 15.r),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
