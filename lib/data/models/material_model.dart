import 'package:hotel_crm/domain/entities/material_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gen/material_model.g.dart';

@JsonSerializable()
class MaterialModel {
  final int id;
  final String name;
  final String unitMeasurement;
  final int currentBalance;
  final String? description;

  MaterialModel({
    required this.id,
    required this.name,
    required this.unitMeasurement,
    required this.currentBalance,
    this.description,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialModelToJson(this);

  MaterialEntity toEntity() {
    return MaterialEntity(
      id: id,
      name: name,
      unitMeasurement: unitMeasurement,
      currentBalance: currentBalance,
      description: description,
    );
  }
}
