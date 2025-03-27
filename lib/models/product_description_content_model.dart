import 'package:equatable/equatable.dart';

class ProductDescriptionContentModel extends Equatable {
  final int id;
  final String contentEn;
  final String contentAr;
  final String titleId;
  final String createdAt;
  final String updatedAt;

  const ProductDescriptionContentModel({
    required this.id,
    required this.contentEn,
    required this.contentAr,
    required this.titleId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductDescriptionContentModel.fromJson(Map<String, dynamic> json) =>
      ProductDescriptionContentModel(
        id: json["id"] ?? 0,
        contentEn: json["content_en"].toString(),
        contentAr: json["content_ar"].toString(),
        titleId: json["title_id"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  @override
  List<Object?> get props => [
        id,
        contentEn,
        contentAr,
        titleId,
        createdAt,
        updatedAt,
      ];
}
