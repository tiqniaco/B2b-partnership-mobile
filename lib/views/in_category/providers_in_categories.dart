import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/in_category/providers_in_category_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
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
          toolbarHeight: context.isTablet ? 70.h : 40.h,
          titleSpacing: 20,
          title: Text(
            translateDatabase(
                arabic: controller.specialization.nameAr!,
                english: controller.specialization.nameEn!),
            style: getBoldStyle(context).copyWith(fontSize: 18.r),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchWidget(
                title: "Search...",
                onTap: () {
                  Get.toNamed(AppRoutes.search);
                },
              ),
              Gap(16),
              SizedBox(
                height: 30.h,
                child: SubCategoryWidget(
                  subSpecializations: controller.subSpecializations,
                ),
              ),
              Gap(24),
              Text(
                "${controller.providers.length} ${"providers founded".tr}",
                style: getMediumStyle(context).copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(16),
              Expanded(
                  child: CustomServerStatusWidget(
                statusRequest: controller.statusRequestServices,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: context.isTablet ? 3 : 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    childAspectRatio: context.isTablet ? 6 / 9 : 6 / 8.3,
                  ),
                  scrollDirection: Axis.vertical,
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
        ),
      );
    });
  }
}
