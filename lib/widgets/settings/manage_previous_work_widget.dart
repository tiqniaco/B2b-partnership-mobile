import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/pervious_work_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ManagePreviousWorkWidget extends StatelessWidget {
  const ManagePreviousWorkWidget({
    super.key,
    required this.model,
    required this.onDelete,
  });
  final ProviderPerviousWorkModel model;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.managePreviousWorkDetailsView,
            arguments: {"model": model});
      },
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  model.image!,
                ))),
        child: Container(
          //  width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: blackColor.withAlpha(95)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                IconButton(
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Colors.white.withAlpha(120)),
                  ),
                  onPressed: () {
                    onDelete();
                  },
                  icon: model.isDeleteLoading
                      ? CircularProgressIndicator()
                      : Icon(
                          Icons.delete,
                          color: primaryColor,
                        ),
                ),
                IconButton(
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Colors.white.withAlpha(120)),
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoutes.editPreviousWork,
                        arguments: {"model": model});
                  },
                  icon: Icon(
                    Icons.edit,
                    color: primaryColor,
                  ),
                ),
              ]),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: Directionality(
                  textDirection: containsArabic(model.titleEn!)
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: Text(
                    model.titleEn!,
                    style: getMediumStyle(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              Directionality(
                textDirection: containsArabic(model.description!)
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Text(
                  model.description!,
                  style: getRegularStyle(context).copyWith(
                    color: whiteColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
