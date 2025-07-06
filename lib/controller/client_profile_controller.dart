// ignore_for_file: avoid_print

import 'package:b2b_partenership/controller/service_details_controller.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/client_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ClientProfileController extends GetxController {
  late PageController pageController;
  int selectedIndex = 0;
  ClientModel? clientModel;
  late String clientId;
  int rating = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController reviewController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestReview = StatusRequest.loading;
  StatusRequest statusRequestServices = StatusRequest.loading;
  StatusRequest statusRequestPerviousWork = StatusRequest.loading;

  @override
  onInit() async {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex);
    clientId = Get.arguments['id'];
    await getClient();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) {
    selectedIndex = index;
    update();
  }

  void onTabTapped(int index) {
    selectedIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  Future<void> getClient() async {
    statusRequest = StatusRequest.loading;
    final result = await CustomRequest<ClientModel>(
      path: ApiConstance.getClientMenu(clientId),
      fromJson: (json) {
        return ClientModel.fromJson(json['data']);
      },
    ).sendGetRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      clientModel = r;
      statusRequest = StatusRequest.success;
      update();
    });
  }

  contactMethods() {
    Get.defaultDialog(
        titleStyle: getMediumStyle(Get.context!),
        title: "Contact with".tr,
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              ProviderContactMethodWidget(
                onTap: () {
                  _launchURL('tel://${clientModel!.phone}');
                },
                icon: FontAwesomeIcons.phone,
                value: "(+20) ${clientModel?.phone}",
                iconColor: Colors.green,
              ),
              ProviderContactMethodWidget(
                onTap: () {
                  _launchURL('mailto://${clientModel!.email}');
                },
                icon: FontAwesomeIcons.envelope,
                value: clientModel!.email ?? "",
                iconColor: Colors.red,
              ),
              Gap(10.h),
            ],
          ),
        ));
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      print('Could not launch $url');
    }
  }
}
