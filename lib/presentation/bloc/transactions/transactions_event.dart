part of 'transactions_bloc.dart';

sealed class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

final class LoadTransactionsEvent extends TransactionsEvent {}

final class AddTransactionEvent extends TransactionsEvent {
  final TransactionEntity transaction;

  const AddTransactionEvent({required this.transaction});

  @override
  List<Object> get props => [transaction];
}
