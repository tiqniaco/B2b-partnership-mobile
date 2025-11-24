class ClientMenuModel {
  String status;
  String message;
  int jobsCount;
  int shoppingCount;
  int servicesCount;
  int complaintsCount;
  Data data;

  ClientMenuModel({
    required this.status,
    required this.message,
    required this.jobsCount,
    required this.shoppingCount,
    required this.servicesCount,
    required this.complaintsCount,
    required this.data,
  });

  factory ClientMenuModel.fromJson(Map<String, dynamic> json) =>
      ClientMenuModel(
        status: json["status"],
        message: json["message"],
        jobsCount: json["jobsCount"],
        shoppingCount: json["shoppingCount"],
        servicesCount: json["servicesCount"],
        complaintsCount: json["complaintsCount"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "jobsCount": jobsCount,
        "shoppingCount": shoppingCount,
        "servicesCount": servicesCount,
        "complaintsCount": complaintsCount,
        "data": data.toJson(),
      };
}

class Data {
  int userId;
  String name;
  String email;
  String countryCode;
  String phone;
  dynamic image;
  int clientId;
  int countryId;
  String countryNameAr;
  String countryNameEn;
  int governmentId;
  String governmentNameAr;
  String governmentNameEn;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic providerId;

  Data({
    required this.userId,
    required this.name,
    required this.email,
    required this.countryCode,
    required this.phone,
    required this.image,
    required this.clientId,
    required this.countryId,
    required this.countryNameAr,
    required this.countryNameEn,
    required this.governmentId,
    required this.governmentNameAr,
    required this.governmentNameEn,
    required this.createdAt,
    required this.updatedAt,
    required this.providerId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"] ?? '',
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        countryCode: json["country_code"] ?? '',
        phone: json["phone"] ?? "",
        image: json["image"] ?? '',
        clientId: json["client_id"] ?? "",
        countryId: json["country_id"] ?? "",
        countryNameAr: json["country_name_ar"] ?? '',
        countryNameEn: json["country_name_en"] ?? '',
        governmentId: json["government_id"] ?? '',
        governmentNameAr: json["government_name_ar"] ?? '',
        governmentNameEn: json["government_name_en"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        providerId: json["provider_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "country_code": countryCode,
        "phone": phone,
        "image": image,
        "client_id": clientId,
        "country_id": countryId,
        "country_name_ar": countryNameAr,
        "country_name_en": countryNameEn,
        "government_id": governmentId,
        "government_name_ar": governmentNameAr,
        "government_name_en": governmentNameEn,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "provider_id": providerId,
      };
}
