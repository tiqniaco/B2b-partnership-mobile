import 'package:b2b_partenership/controller/auth/signup_controller.dart';
import 'package:b2b_partenership/widgets/custome_phone_widget.dart';
import 'package:b2b_partenership/widgets/select_city_widget.dart';
import 'package:b2b_partenership/widgets/select_country_widget.dart';
import 'package:b2b_partenership/widgets/select_provider_widget.dart';
import 'package:b2b_partenership/widgets/select_spacialization_widget.dart';
import 'package:b2b_partenership/widgets/select_sup_spacialization_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderSignup2 extends StatelessWidget {
  const ProviderSignup2({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return GetBuilder<SignupController>(
      builder: (controller) => Form(
        key: controller.formKeyCustomer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Gap(20.h),
            Row(
              children: [
                Expanded(
                  child: SelectCountryWidget(
                    enabled: false,
                  ),
                ),
                Gap(10),
                Expanded(child: SelectCityWidget()),
              ],
            ),
            //Gap(20.h),
            Gap(20.h),
            CustomePhoneWidget(),
            Gap(10.h),
            SelectProviderWidget(),
            Gap(20.h),
            SelectSpacializationWidget(),
            Gap(20.h),
            SelectSupSpacializationWidget(),
            Gap(20.h),
          ],
        ),
      ),
    );
  }
}
