import 'package:hotel_crm/domain/entities/material_entity.dart';

abstract interface class MaterialRepoInterface {
  Future<List<MaterialEntity>> getMaterials();
}
