import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_crm/data/repositories/material_repo_interface.dart';
import 'package:hotel_crm/domain/entities/material_entity.dart';

part 'materials_event.dart';
part 'materials_state.dart';

class MaterialsBloc extends Bloc<MaterialsEvent, MaterialsState> {
  MaterialsBloc({required MaterialRepoInterface repo})
    : _repo = repo,
      super(MaterialInitial()) {
    on<LoadMaterialsEvent>(_onLoadMaterials);
  }

  final MaterialRepoInterface _repo;

  FutureOr<void> _onLoadMaterials(
    LoadMaterialsEvent event,
    Emitter<MaterialsState> emit,
  ) async {
    try {
      emit(MaterialsLoading());
      final materials = await _repo.getMaterials();
      emit(MaterialsLoaded(materials: materials));
    } catch (e, st) {
      log('$e: $st');
    }
  }
}
