import 'package:get/get.dart';

class OrdersController extends GetxController {
  String selectedStatus = 'All';
  List<String> orderStatus = [
    'All',
    'Pending',
    'Active',
    'Complete',
    "Delivered",
    "Canceled",
  ];

  String selectedPayment = 'All';
  List<String> paymentStatus = [
    'All',
    'Pending',
    'Complete',
  ];

  onStatusChanged(String newValue) {
    selectedStatus = newValue;
    update();
  }

  onPaymentChanged(String newValue) {
    selectedPayment = newValue;
    update();
  }
}
