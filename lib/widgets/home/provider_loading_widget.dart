import 'package:b2b_partenership/core/services/responsive_helper.dart';
import 'package:b2b_partenership/widgets/home/provider_loading.dart';
import 'package:flutter/material.dart';

class ProviderLoadingWidget extends StatelessWidget {
  const ProviderLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: ResponsiveHelper.getValue(
                thinValue: 1.44,
                extraSmallValue: 1.59,
                smallValue: 1.35,
                mediumValue: 1.55,
                largeValue: 1.1,
                extraLargeValue: 1.1)),
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (context, index) => ProviderLoading());
  }
}
