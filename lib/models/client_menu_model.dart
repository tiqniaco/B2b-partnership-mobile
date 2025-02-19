import 'package:b2b_partenership/models/client_model.dart';

class ClientMenuModel {
  String? status;
  String? message;
  int? jobsCount;
  int? shoppingCount;
  int? servicesCount;
  int? complaintsCount;
  ClientModel? data;

  ClientMenuModel(
      {this.status,
      this.message,
      this.jobsCount,
      this.shoppingCount,
      this.servicesCount,
      this.complaintsCount,
      this.data});

  ClientMenuModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    jobsCount = json['jobsCount'];
    shoppingCount = json['shoppingCount'];
    servicesCount = json['servicesCount'];
    complaintsCount = json['complaintsCount'];
    data = json['data'] != null ? ClientModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['jobsCount'] = jobsCount;
    data['shoppingCount'] = shoppingCount;
    data['servicesCount'] = servicesCount;
    data['complaintsCount'] = complaintsCount;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
