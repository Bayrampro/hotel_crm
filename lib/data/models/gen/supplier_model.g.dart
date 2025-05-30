// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../supplier_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierModel _$SupplierModelFromJson(Map<String, dynamic> json) =>
    SupplierModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      contactPerson: json['contactPerson'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      address: json['address'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SupplierModelToJson(SupplierModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contactPerson': instance.contactPerson,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'createdAt': instance.createdAt.toIso8601String(),
    };
