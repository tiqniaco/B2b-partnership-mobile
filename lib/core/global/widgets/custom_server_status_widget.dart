import 'package:flutter/material.dart';
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
    this.emptyMessage,
  });

  final StatusRequest statusRequest;
  final Widget child;
  final String? errorMessage;
  final double? height;
  final String? emptyMessage;
  @override
  Widget build(BuildContext context) {
    return switch (statusRequest) {
      StatusRequest.loading =>
    
        Container(
          height: height,
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
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
          child: CustomEmptyWidget(
            text: emptyMessage,
          ),
        ),
      StatusRequest.initial => child,
    };
  }
}
