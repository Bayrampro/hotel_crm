// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: (json['id'] as num).toInt(),
      materialId: (json['materialId'] as num).toInt(),
      type: json['type'] as String,
      count: (json['count'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      comment: json['comment'] as String,
      supplierId: (json['supplierId'] as num).toInt(),
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'materialId': instance.materialId,
      'type': instance.type,
      'count': instance.count,
      'date': instance.date.toIso8601String(),
      'comment': instance.comment,
      'supplierId': instance.supplierId,
    };
