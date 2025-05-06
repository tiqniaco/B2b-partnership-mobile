import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';

import '/core/constants/app_constants.dart';
import '/core/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sliding_logo.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slidingAnimation;
  String? code;
  StatusRequest statusRequest = StatusRequest.loading;

  @override
  initState() {
    super.initState();
    _initAnimationControllers();

    _navigateToNext();

    Get.find<NotificationsService>().initialize();
    Get.find<AppPreferences>().init();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlidingLogo(slidingAnimation: _slidingAnimation),
    );
  }

  Future<void> _navigateToNext() async {
    Future.delayed(kSplashDuration, () async {
      if (Get.find<AppPreferences>().getUserRole() == "client") {
        Get.offNamed(AppRoutes.clientHomeLayout);
      } else if (Get.find<AppPreferences>().getUserRole() == "provider") {
        await getVerifyCode();
        if (code == "0" || code == null) {
          Get.toNamed(AppRoutes.authNoteScreen, arguments: {"code": code});
        } else if (code == "1") {
          if (Get.find<AppPreferences>().getStep() == "1") {
            Get.toNamed(AppRoutes.authNoteScreen, arguments: {"code": code});
          } else {
            Get.offNamed(AppRoutes.providerHomeLayout);
          }
        }
      } else {
        // Get.offNamed(AppRoutes.login);
        Get.offNamed(AppRoutes.clientHomeLayout);
      }
    });
  }

  Future<void> getVerifyCode() async {
    statusRequest = StatusRequest.loading;
    final result = await CustomRequest<Map<String, dynamic>>(
        path: ApiConstance.getVerifyCode,
        fromJson: (json) {
          return json;
        },
        data: {
          "provider_id": Get.find<AppPreferences>().getUserRoleId(),
        }).sendPostRequest();

    result.fold((l) {
      Get.find<AppPreferences>().clear();
      statusRequest = StatusRequest.error;
    }, (r) {
     
      statusRequest = StatusRequest.success;
      code = r['verified_code'];
    });
  }

  void _initAnimationControllers() {
    _animationController = AnimationController(
      vsync: this,
      duration: kSplashAnimationDuration,
    );

    _slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, 0),
    ).animate(_animationController);

    _animationController.forward();
  }
}
