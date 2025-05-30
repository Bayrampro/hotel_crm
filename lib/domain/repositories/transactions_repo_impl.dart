import 'package:hotel_crm/data/data_sources/transactions_data_source.dart';
import 'package:hotel_crm/data/repositories/transactions_repo_interface.dart';
import 'package:hotel_crm/domain/entities/transaction_entity.dart';

class TransactionsRepoImpl implements TransactionsRepoInterface {
  final TransactionsDataSource _dataSource;

  TransactionsRepoImpl({required TransactionsDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    final transactionsData = await _dataSource.getTransactionsFromDb();

    return transactionsData.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addTransaction({required TransactionEntity entity}) async {
    await _dataSource.addTransactionToDb(model: entity.toModel());
  }
}
