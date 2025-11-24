

class OrderModel {
  int id;
  int userId;
  String status;
  double totalPrice;
  DateTime expirationDate;
  dynamic email;
  dynamic phone;
  DateTime createdAt;
  DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalPrice,
    required this.expirationDate,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        userId: json["user_id"],
        status: json["status"],
        totalPrice: json["total_price"]?.toDouble(),
        expirationDate: DateTime.parse(json["expiration_date"]),
        email: json["email"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "status": status,
        "total_price": totalPrice,
        "expiration_date":
            "${expirationDate.year.toString().padLeft(4, '0')}-${expirationDate.month.toString().padLeft(2, '0')}-${expirationDate.day.toString().padLeft(2, '0')}",
        "email": email,
        "phone": phone,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
