import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'logout.dart';

void removeAccountDialog({
  required BuildContext context,
  required bool removeAccountLoading,
  required void Function([List<Object>? ids, bool condition]) update,
}) {
  Get.defaultDialog(
    title: "Remove Account".tr,
    middleText: "Are you sure you want to remove your account?".tr,
    textCancel: "No".tr,
    textConfirm: "Yes".tr,
    onConfirm: () {
      Get.back();
      _removeAccount(context,removeAccountLoading, update );
    },
  );
}

Future<void> _removeAccount(
  BuildContext context,
  bool removeAccountLoading,
  void Function([List<Object>? ids, bool condition]) update,
) async {
  removeAccountLoading = true;
  update();
  final result = await CustomRequest<String>(
    path: ApiConstance.deleteAccount,
    fromJson: (json) {
      return json['message'];
    },
  ).sendPostRequest();
  result.fold((l) {
    AppSnackBars.error(message: l.errMsg);
    removeAccountLoading = false;
    update();
  }, (r) {
    AppSnackBars.success(message: r);
    removeAccountLoading = false;
    logout(context);
    update();
  });
}
