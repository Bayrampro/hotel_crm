part of 'materials_bloc.dart';

sealed class MaterialsEvent extends Equatable {
  const MaterialsEvent();

  @override
  List<Object> get props => [];
}

final class LoadMaterialsEvent extends MaterialsEvent {}
