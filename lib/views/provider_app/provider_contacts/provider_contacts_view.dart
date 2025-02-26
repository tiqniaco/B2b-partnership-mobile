import 'package:b2b_partenership/controller/provider/provider_contacts_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/widgets/request_services/build_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderContactsView extends StatelessWidget {
  const ProviderContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderContactsController>(
      init: ProviderContactsController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Provider Contacts'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildTextField(
                  controller.phoneController,
                  'Phone',
                  Icons.phone,
                  'enter phone number',
                  (val) {
                    return "";
                  },
                  hasValidation: false,
                ),
                Gap(20.h),
                buildTextField(
                  controller.emailController,
                  'Email',
                  Icons.email,
                  'enter email',
                  (val) {
                    return "";
                  },
                  hasValidation: false,
                ),
                Gap(20.h),
                buildTextField(
                  controller.whatsappController,
                  'Address',
                  Icons.location_on,
                  'enter address',
                  (val) {
                    return "";
                  },
                  hasValidation: false,
                ),
                Gap(20.h),
                buildTextField(
                  controller.telegramController,
                  'Telegram',
                  Icons.telegram,
                  'enter telegram',
                  (val) {
                    return "";
                  },
                  hasValidation: false,
                ),
                Gap(20.h),
                buildTextField(
                  controller.instagramController,
                  'Instagram',
                  Icons.location_on,
                  'enter instagram',
                  (val) {
                    return "";
                  },
                  hasValidation: false,
                ),
                Gap(20.h),
                buildTextField(
                  controller.facebookController,
                  'Facebook',
                  Icons.facebook,
                  'enter facebook',
                  (val) {
                    return "";
                  },
                  hasValidation: false,
                ),
                Gap(20.h),
                buildTextField(
                  controller.linkedinController,
                  'Linkedin',
                  Icons.location_on,
                  'enter linkedin',
                  (val) {
                    return "";
                  },
                  hasValidation: false,
                ),
                Gap(20.h),
                buildTextField(
                  controller.websiteController,
                  'Website',
                  Icons.web,
                  'enter website',
                  (val) {
                    return "";
                  },
                  hasValidation: false,
                ),
                Gap(20.h),
                CustomLoadingButton(
                  onPressed: () {
                    controller.updateProviderContacts();
                  },
                  text: 'Change'.tr,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
