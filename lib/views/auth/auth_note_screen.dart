import 'dart:io';

import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/auth/auth_note_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthNoteScreen extends StatelessWidget {
  AuthNoteScreen({super.key});
  final controller = Get.put(AuthNoteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: controller.code == "1"
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/approve.jpg",
                        height: 200,
                        // width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Your application login request has been accepted".tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomLoadingButton(
                        text: 'Login'.tr,
                        onPressed: () {
                          Get.toNamed(AppRoutes.login);
                        },
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/verify.jpg",
                        height: 200,
                        // width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("The signup request has been sent successfully".tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Wait the admin's approval\nYou will receive a response notification\nas soon as possible"
                              .tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomLoadingButton(
                        text: 'OK'.tr,
                        onPressed: () {
                          if (Platform.isAndroid) {
                            SystemNavigator.pop();
                          } else if (Platform.isIOS) {
                            exit(0);
                          }
                        },
                      )
                    ],
                  )),
      ),
    );
  }
}
