import 'package:b2b_partenership/controller/service_details_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FeatureWidget extends StatelessWidget {
  const FeatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServiceDetailsController());
    return GetBuilder<ServiceDetailsController>(builder: (controller) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.serviceFeatures.length,
        itemBuilder: (context, index) {
          final feature = controller.serviceFeatures[index];
          return FeaturItem(
            feature: translateDatabase(
                arabic: feature.featureAr!, english: feature.featureEn!),
          );
        },
      );
    });
  }
}

class FeaturItem extends StatelessWidget {
  final String feature;

  const FeaturItem({
    super.key,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.check,
            color: primaryColor,
            size: 22.r,
          ),
          Gap(10),
          Expanded(
            child: Text(
              feature,
              style: getRegularStyle(context),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}
