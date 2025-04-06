import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/in_category/providers_in_category_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:b2b_partenership/widgets/home/provider_widget.dart';
import 'package:b2b_partenership/widgets/home/search_widget.dart';
import 'package:b2b_partenership/widgets/home/sub_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProvidersInCategories extends StatefulWidget {
  const ProvidersInCategories({super.key});

  @override
  State<ProvidersInCategories> createState() => _ProvidersInCategoriesState();
}

class _ProvidersInCategoriesState extends State<ProvidersInCategories>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Get.put(ProvidersInCategoryController());
    return GetBuilder<ProvidersInCategoryController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          toolbarHeight: context.isTablet ? 70.h : 40.h,
          titleSpacing: 20,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 18.r,
                ),
              ),
              Gap(5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category!",
                      style: getRegularStyle(context).copyWith(
                        color: greyColor,
                        fontWeight: FontManager.mediumFontWeight,
                      ),
                    ),
                    Text(
                      translateDatabase(
                          arabic: controller.specialization.nameAr!,
                          english: controller.specialization.nameEn!),
                      style: getMediumStyle(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Container(
              height: 42.h,
              width: 42.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  controller.specialization.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gap(20.w)
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SearchWidget(
                onTap: () {
                  Get.toNamed(AppRoutes.search);
                },
              ),
            ),
            Gap(5),
            FractionallySizedBox(
              widthFactor: 1,
              child: Divider(),
            ),
            Gap(5),
            SizedBox(
              height: 35.h,
              child: SubCategoryWidget(
                subSpecializations: controller.subSpecializations,
              ),
            ),
            Gap(15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "${controller.providers.length} ${"providers founded".tr}",
                style: getMediumStyle(context).copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Gap(10),
            Expanded(
                child: CustomServerStatusWidget(
              statusRequest: controller.statusRequestServices,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.isTablet ? 3 : 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                  childAspectRatio: context.isTablet ? 6 / 9 : 6 / 10,
                ),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemCount: controller.providers.length,
                itemBuilder: (context, index) => ProviderWidget(
                    provider: controller.providers[index],
                    toggleFavorite: () {
                      controller.toggleFavorites(
                          controller.providers[index].providerId.toString());
                    }),
              ),
            )),
          ],
        ),
      );
    });
  }
}
