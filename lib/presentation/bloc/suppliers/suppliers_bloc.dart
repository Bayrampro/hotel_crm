import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_crm/data/repositories/suppliers_repo_interface.dart';
import 'package:hotel_crm/domain/entities/supplier_entity.dart';

part 'suppliers_event.dart';
part 'suppliers_state.dart';

class SuppliersBloc extends Bloc<SuppliersEvent, SuppliersState> {
  SuppliersBloc({required SuppliersRepoInterface repo})
    : _repo = repo,
      super(SuppliersInitial()) {
    on<LoadSuppliersEvent>(_onLoadSuppliers);
    on<UpdateSuppliersEvent>(_onUpdateSuppliers);
    on<AddSuppliersEvent>(_onAddSuppliers);
  }

  final SuppliersRepoInterface _repo;

  FutureOr<void> _onLoadSuppliers(
    LoadSuppliersEvent event,
    Emitter<SuppliersState> emit,
  ) async {
    try {
      emit(SuppliersLoading());
      final suppliers = await _repo.getSuppliers();
      emit(SuppliersLoaded(suppliers: suppliers));
    } catch (e, st) {
      log('$e: $st');
    }
  }

  FutureOr<void> _onUpdateSuppliers(
    UpdateSuppliersEvent event,
    Emitter<SuppliersState> emit,
  ) async {
    try {
      emit(SuppliersLoading());
      await _repo.updateSupplier(entity: event.supplier);
      emit(SuppliersSuccess(msg: 'Поставщик изменен успешно!'));
    } catch (e, st) {
      log('$e: $st');
    }
  }

  FutureOr<void> _onAddSuppliers(
    AddSuppliersEvent event,
    Emitter<SuppliersState> emit,
  ) async {
    try {
      emit(SuppliersLoading());
      await _repo.addSupplier(entity: event.supplier);
      emit(SuppliersSuccess(msg: 'Поставщик добавлен успешно!'));
    } catch (e, st) {
      log('$e: $st');
    }
  }
}
