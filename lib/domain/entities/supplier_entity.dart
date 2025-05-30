import 'package:hotel_crm/data/models/supplier_model.dart';

class SupplierEntity {
  final int id;
  final String name;
  final String contactPerson;
  final String phone;
  final String? email;
  final String? address;
  final DateTime createdAt;

  SupplierEntity({
    required this.id,
    required this.name,
    required this.contactPerson,
    required this.phone,
    this.email,
    this.address,
    required this.createdAt,
  });

  SupplierModel toModel() {
    return SupplierModel(
      id: id,
      name: name,
      contactPerson: contactPerson,
      phone: phone,
      address: address,
      email: email,
      createdAt: createdAt,
    );
  }
}
