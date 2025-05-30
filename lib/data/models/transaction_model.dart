import 'package:hotel_crm/domain/entities/transaction_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gen/transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  final int id;
  final int materialId;
  final String type;
  final int count;
  final DateTime date;
  final String? comment;
  final int supplierId;

  TransactionModel({
    required this.id,
    required this.materialId,
    required this.type,
    required this.count,
    required this.date,
    this.comment,
    required this.supplierId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      materialId: materialId,
      type: type,
      count: count,
      date: date,
      comment: comment,
      supplierId: supplierId,
    );
  }
}
