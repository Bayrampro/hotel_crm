import 'package:hotel_crm/domain/entities/supplier_entity.dart';

abstract interface class SuppliersRepoInterface {
  Future<List<SupplierEntity>> getSuppliers();
  Future<void> updateSupplier({required SupplierEntity entity});
  Future<void> addSupplier({required SupplierEntity entity});
}
