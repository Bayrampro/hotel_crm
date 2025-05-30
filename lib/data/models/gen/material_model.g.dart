// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../material_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialModel _$MaterialModelFromJson(Map<String, dynamic> json) =>
    MaterialModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      unitMeasurement: json['unitMeasurement'] as String,
      currentBalance: (json['currentBalance'] as num).toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$MaterialModelToJson(MaterialModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unitMeasurement': instance.unitMeasurement,
      'currentBalance': instance.currentBalance,
      'description': instance.description,
    };
