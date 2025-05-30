part of 'suppliers_bloc.dart';

sealed class SuppliersEvent extends Equatable {
  const SuppliersEvent();

  @override
  List<Object> get props => [];
}

final class LoadSuppliersEvent extends SuppliersEvent {}

final class UpdateSuppliersEvent extends SuppliersEvent {
  final SupplierEntity supplier;

  const UpdateSuppliersEvent({required this.supplier});

  @override
  List<Object> get props => [supplier];
}

final class AddSuppliersEvent extends SuppliersEvent {
  final SupplierEntity supplier;

  const AddSuppliersEvent({required this.supplier});

  @override
  List<Object> get props => [supplier];
}
