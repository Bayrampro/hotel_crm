import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_crm/core/exeptions/limit_exeption.dart';
import 'package:hotel_crm/data/repositories/transactions_repo_interface.dart';
import 'package:hotel_crm/domain/entities/transaction_entity.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc({required TransactionsRepoInterface repo})
    : _repo = repo,
      super(TransactionsInitial()) {
    on<LoadTransactionsEvent>(_onLoadTransactions);
    on<AddTransactionEvent>(_onAddTransactionEvent);
  }

  final TransactionsRepoInterface _repo;

  FutureOr<void> _onLoadTransactions(
    LoadTransactionsEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      emit(TransactionsLoading());
      final transactions = await _repo.getTransactions();
      emit(TransactionsLoaded(transactions: transactions));
    } catch (e, st) {
      log('$e: $st');
    }
  }

  FutureOr<void> _onAddTransactionEvent(
    AddTransactionEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      emit(TransactionsLoading());
      await _repo.addTransaction(entity: event.transaction);
      emit(TransactionSuccess(msg: 'Операция добавлена успешно!'));
    } on LimitExeption catch (e, st) {
      log('$e: $st');
      emit(TransactionError(msg: e.message));
    } catch (e, st) {
      log('$e: $st');
    }
  }
}
