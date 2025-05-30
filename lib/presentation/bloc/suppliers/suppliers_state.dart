part of 'suppliers_bloc.dart';

sealed class SuppliersState extends Equatable {
  const SuppliersState();

  @override
  List<Object> get props => [];
}

final class SuppliersInitial extends SuppliersState {}

final class SuppliersLoading extends SuppliersState {}

final class SuppliersLoaded extends SuppliersState {
  final List<SupplierEntity> suppliers;

  const SuppliersLoaded({required this.suppliers});

  @override
  List<Object> get props => [suppliers];
}

final class SuppliersSuccess extends SuppliersState {
  final String msg;

  const SuppliersSuccess({required this.msg});

  @override
  List<Object> get props => [msg];
}
