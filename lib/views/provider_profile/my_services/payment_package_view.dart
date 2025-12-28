import 'package:b2b_partenership/controller/settings/provider/my_services/add_provider_service_controller.dart';
import 'package:b2b_partenership/models/payment_model.dart';
import 'package:b2b_partenership/widgets/payments/package_card.dart';
import 'package:b2b_partenership/widgets/payments/payment_months_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentsView extends GetView<AddProviderServiceController> {
  const PaymentsView({super.key, required this.packages});
  final List<PaymentPackage> packages;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProviderServiceController>(
      id: 'packages',
      builder: (context) => Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Select the perfect package for your needs',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: PaymentMonthsWidget(
              months: controller.monthsList,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: packages.length,
              itemBuilder: (context, index) {
                return PaymentPackageCard(
                  package: packages[index],
                  isSelected: true,
                  // onTapDelete: () {
                  //   controller.deletePackage(packages[index].id!);
                  // },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
