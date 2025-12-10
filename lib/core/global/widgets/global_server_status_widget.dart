import 'package:b2b_partenership/core/enums/status_request.dart';

import 'package:flutter/material.dart';

class GlobalServerStatusWidget extends StatelessWidget {
  const GlobalServerStatusWidget({
    super.key,
    required this.statusRequest,
    required this.loadingChild,
    required this.successChild,
    required this.errorChild,
    required this.noConnectionChild,
    required this.noDataChild,
  });

  final StatusRequest statusRequest;
  final Widget loadingChild;
  final Widget successChild;
  final Widget errorChild;
  final Widget noConnectionChild;
  final Widget noDataChild;

  @override
  Widget build(BuildContext context) {
    return switch (statusRequest) {
      StatusRequest.loading => loadingChild,
      StatusRequest.success => successChild,
      StatusRequest.error => errorChild,
      StatusRequest.noConnection => noConnectionChild,
      StatusRequest.noData => noDataChild,
      StatusRequest.initial => successChild,
    };
  }
}
