import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/pervious_work_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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
        Get.toNamed(AppRoutes.providerPreviousWork,
            arguments: {"model": model});
      },
      child: Container(
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: borderColor)),
        child: Row(
          children: [
            Container(
              height: 105.h,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        model.image!,
                      ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: whiteColor),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            style: ButtonStyle(
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.all(5)),
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
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.all(5)),
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
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.titleEn!,
                      textDirection: containsArabic(model.titleEn!)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      style: getMediumStyle(context).copyWith(
                        fontWeight: FontWeight.normal,
                        color: blackColor,
                      ),
                    ),
                    Gap(8),
                    Text(
                      model.description!,
                      textDirection: containsArabic(model.titleEn!)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      style: getRegularStyle(context).copyWith(
                          color: Colors.black54, fontWeight: FontWeight.normal),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
