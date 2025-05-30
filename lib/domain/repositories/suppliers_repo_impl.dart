import 'package:hotel_crm/data/data_sources/suppliers_data_source.dart';
import 'package:hotel_crm/data/repositories/suppliers_repo_interface.dart';
import 'package:hotel_crm/domain/entities/supplier_entity.dart';

class SuppliersRepoImpl implements SuppliersRepoInterface {
  final SuppliersDataSource _dataSource;

  SuppliersRepoImpl({required SuppliersDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<List<SupplierEntity>> getSuppliers() async {
    final suppliersData = await _dataSource.getSuppliersFromDb();

    return suppliersData.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateSupplier({required SupplierEntity entity}) async {
    await _dataSource.updateSupplierFromDb(model: entity.toModel());
  }

  @override
  Future<void> addSupplier({required SupplierEntity entity}) async {
    await _dataSource.addSupplierToDb(model: entity.toModel());
  }
}
