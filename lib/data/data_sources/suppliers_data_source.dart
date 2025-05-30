import 'package:hotel_crm/data/local_database.dart';
import 'package:hotel_crm/data/models/supplier_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SuppliersDataSource {
  final LocalDatabase _db;

  SuppliersDataSource({required LocalDatabase db}) : _db = db;

  Future<List<SupplierModel>> getSuppliersFromDb() async {
    final local = await _db.database;

    final List<Map<String, dynamic>> data = await local.query('suppliers');
    final suppliers = data.map((map) => SupplierModel.fromJson(map)).toList();
    return suppliers;
  }

  Future<void> updateSupplierFromDb({required SupplierModel model}) async {
    final local = await _db.database;

    await local.update(
      'suppliers',
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> addSupplierToDb({required SupplierModel model}) async {
    final local = await _db.database;

    await local.insert('suppliers', {
      "name": model.name,
      "contactPerson": model.contactPerson,
      "phone": model.contactPerson,
      "email": model.email,
      "address": model.address,
      "createdAt": model.createdAt.toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
