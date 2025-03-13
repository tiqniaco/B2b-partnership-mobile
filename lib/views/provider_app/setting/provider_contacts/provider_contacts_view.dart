import 'package:b2b_partenership/controller/provider/provider_contacts_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/global/widgets/custom_sliver_server_status_widget.dart';
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
            title: Text('My Contacts'.tr),
          ),
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 16.w,
                ),
                sliver: CustomSliverServerStatusWidget(
                  statusRequest: controller.statusRequest,
                  errorMessage: controller.errorMessage,
                  child: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Gap(20.h),
                        buildTextField(
                          controller.phoneController,
                          'Phone'.tr,
                          Icons.phone,
                          'enter phone number'.tr,
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                        buildTextField(
                          controller.emailController,
                          'Email'.tr,
                          Icons.email,
                          'enter email'.tr,
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                        buildTextField(
                          controller.whatsappController,
                          'Address'.tr,
                          Icons.location_on,
                          'enter address'.tr,
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                        buildTextField(
                          controller.telegramController,
                          'Telegram'.tr,
                          Icons.telegram,
                          'enter telegram'.tr,
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                        buildTextField(
                          controller.instagramController,
                          'Instagram'.tr,
                          Icons.location_on,
                          'enter instagram'.tr,
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                        buildTextField(
                          controller.facebookController,
                          'Facebook'.tr,
                          Icons.facebook,
                          'enter facebook'.tr,
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                        buildTextField(
                          controller.linkedinController,
                          'Linkedin'.tr,
                          Icons.location_on,
                          'enter linkedin'.tr,
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                        buildTextField(
                          controller.websiteController,
                          'Website'.tr,
                          Icons.web,
                          'enter website'.tr,
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(context.mediaQueryPadding.bottom + 50.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: BottomAppBar(
            height: 0.1.sh,
            child: Column(
              children: [
                CustomLoadingButton(
                  onPressed: () {
                    return controller.updateProviderContacts();
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
