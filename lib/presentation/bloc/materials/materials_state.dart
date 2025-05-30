part of 'materials_bloc.dart';

sealed class MaterialsState extends Equatable {
  const MaterialsState();

  @override
  List<Object> get props => [];
}

final class MaterialInitial extends MaterialsState {}

final class MaterialsLoading extends MaterialsState {}

final class MaterialsLoaded extends MaterialsState {
  final List<MaterialEntity> materials;

  const MaterialsLoaded({required this.materials});

  @override
  List<Object> get props => [materials];
}
