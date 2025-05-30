import 'package:hotel_crm/data/data_sources/material_data_source.dart';
import 'package:hotel_crm/data/repositories/material_repo_interface.dart';
import 'package:hotel_crm/domain/entities/material_entity.dart';

class MaterialRepoImpl implements MaterialRepoInterface {
  final MaterialDataSource _dataSource;

  MaterialRepoImpl({required MaterialDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<List<MaterialEntity>> getMaterials() async {
    final materialsData = await _dataSource.getMaterialsFromDb();

    return materialsData.map((model) => model.toEntity()).toList();
  }
}
