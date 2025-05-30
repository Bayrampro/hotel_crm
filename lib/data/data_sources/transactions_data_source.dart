import 'package:hotel_crm/core/exeptions/limit_exeption.dart';
import 'package:hotel_crm/data/local_database.dart';
import 'package:hotel_crm/data/models/transaction_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TransactionsDataSource {
  final LocalDatabase _db;

  TransactionsDataSource({required LocalDatabase db}) : _db = db;

  Future<List<TransactionModel>> getTransactionsFromDb() async {
    final local = await _db.database;

    final List<Map<String, dynamic>> data = await local.query('transactions');
    final transactions =
        data.map((map) => TransactionModel.fromJson(map)).toList();
    return transactions;
  }

  Future<void> addTransactionToDb({required TransactionModel model}) async {
    final local = await _db.database;

    final material = await local.query(
      'materials',
      columns: ['currentBalance'],
      where: 'id = ?',
      whereArgs: [model.materialId],
    );

    if (material.isNotEmpty) {
      final currentBalance = material.first['currentBalance'] as int;

      final newBalance =
          model.type.toLowerCase() == 'приход'
              ? currentBalance + model.count
              : currentBalance - model.count;

      if (newBalance < 0) {
        throw LimitExeption('Вы пытаетесть расходовать больше чем есть!');
      }

      await local.insert('transactions', {
        "materialId": model.materialId,
        "type": model.type,
        "count": model.count,
        "date": model.date.toIso8601String(),
        "comment": model.comment,
        "supplierId": model.supplierId,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      await local.update(
        'materials',
        {'currentBalance': newBalance},
        where: 'id = ?',
        whereArgs: [model.materialId],
      );
    }
  }
}
