import 'package:hotel_crm/domain/entities/supplier_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gen/supplier_model.g.dart';

@JsonSerializable()
class SupplierModel {
  final int id;
  final String name;
  final String contactPerson;
  final String phone;
  final String? email;
  final String? address;
  final DateTime createdAt;

  SupplierModel({
    required this.id,
    required this.name,
    required this.contactPerson,
    required this.phone,
    this.email,
    this.address,
    required this.createdAt,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) =>
      _$SupplierModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierModelToJson(this);

  SupplierEntity toEntity() {
    return SupplierEntity(
      id: id,
      name: name,
      contactPerson: contactPerson,
      phone: phone,
      email: email,
      address: address,
      createdAt: createdAt,
    );
  }
}
