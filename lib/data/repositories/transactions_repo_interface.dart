import 'package:hotel_crm/domain/entities/transaction_entity.dart';

abstract interface class TransactionsRepoInterface {
  Future<List<TransactionEntity>> getTransactions();
  Future<void> addTransaction({required TransactionEntity entity});
}
