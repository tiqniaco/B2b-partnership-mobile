import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '/core/enums/status_request.dart';
import '/core/global/widgets/custom_empty_widget.dart';
import '/core/global/widgets/custom_error_widget.dart';

class CustomServerStatusWidget extends StatelessWidget {
  const CustomServerStatusWidget({
    super.key,
    required this.statusRequest,
    required this.child,
    this.errorMessage,
    this.height,
  });

  final StatusRequest statusRequest;
  final Widget child;
  final String? errorMessage;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return switch (statusRequest) {
      StatusRequest.loading => Skeletonizer(
          enabled: true,
          child: child,
        ),
      // Container(
      //     height: height,
      //     alignment: Alignment.center,
      //     child: const CustomLoadingWidget(),
      //   ),
      StatusRequest.success => child,
      StatusRequest.error => Container(
          height: height,
          alignment: Alignment.center,
          child: CustomErrorWidget(
            message: errorMessage,
          ),
        ),
      StatusRequest.noConnection => Container(
          height: height,
          alignment: Alignment.center,
          child: CustomErrorWidget(
            message: errorMessage,
          ),
        ),
      StatusRequest.noData => Container(
          height: height,
          alignment: Alignment.center,
          child: const CustomEmptyWidget(),
        ),
      StatusRequest.initial => child,
    };
  }
}
