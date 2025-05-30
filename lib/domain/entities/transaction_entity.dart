import 'package:hotel_crm/data/models/transaction_model.dart';

class TransactionEntity {
  final int id;
  final int materialId;
  final String type;
  final int count;
  final DateTime date;
  final String? comment;
  final int supplierId;

  TransactionEntity({
    required this.id,
    required this.materialId,
    required this.type,
    required this.count,
    required this.date,
    this.comment,
    required this.supplierId,
  });

  TransactionModel toModel() {
    return TransactionModel(
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
