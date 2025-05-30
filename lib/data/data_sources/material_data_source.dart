import 'package:hotel_crm/data/local_database.dart';
import 'package:hotel_crm/data/models/material_model.dart';

class MaterialDataSource {
  final LocalDatabase _db;

  MaterialDataSource({required LocalDatabase db}) : _db = db;

  Future<List<MaterialModel>> getMaterialsFromDb() async {
    final local = await _db.database;

    final List<Map<String, dynamic>> data = await local.query('materials');
    final materials = data.map((map) => MaterialModel.fromJson(map)).toList();
    return materials;
  }
}
