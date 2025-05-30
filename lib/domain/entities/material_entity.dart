import 'package:hotel_crm/data/models/material_model.dart';

class MaterialEntity {
  final int id;
  final String name;
  final String unitMeasurement;
  final int currentBalance;
  final String? description;

  MaterialEntity({
    required this.id,
    required this.name,
    required this.unitMeasurement,
    required this.currentBalance,
    this.description,
  });

  MaterialModel toModel() {
    return MaterialModel(
      id: id,
      name: name,
      unitMeasurement: unitMeasurement,
      currentBalance: currentBalance,
    );
  }
}
