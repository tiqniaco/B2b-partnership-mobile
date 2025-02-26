import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderContactsController extends GetxController {
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final whatsappController = TextEditingController();
  final telegramController = TextEditingController();
  final instagramController = TextEditingController();
  final facebookController = TextEditingController();
  final linkedinController = TextEditingController();
  final websiteController = TextEditingController();

  @override
  void onClose() {
    phoneController.dispose();
    emailController.dispose();
    whatsappController.dispose();
    telegramController.dispose();
    instagramController.dispose();
    facebookController.dispose();
    linkedinController.dispose();
    websiteController.dispose();
    super.onClose();
  }

  Future<void> updateProviderContacts() async {}
}
