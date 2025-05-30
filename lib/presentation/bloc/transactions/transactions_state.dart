part of 'transactions_bloc.dart';

sealed class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object> get props => [];
}

final class TransactionsInitial extends TransactionsState {}

final class TransactionsLoading extends TransactionsState {}

final class TransactionsLoaded extends TransactionsState {
  final List<TransactionEntity> transactions;

  const TransactionsLoaded({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

final class TransactionSuccess extends TransactionsState {
  final String msg;

  const TransactionSuccess({required this.msg});

  @override
  List<Object> get props => [msg];
}

final class TransactionError extends TransactionsState {
  final String msg;

  const TransactionError({required this.msg});

  @override
  List<Object> get props => [msg];
}
