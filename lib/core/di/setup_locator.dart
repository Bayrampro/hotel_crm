import 'package:get_it/get_it.dart';
import 'package:hotel_crm/data/data_sources/material_data_source.dart';
import 'package:hotel_crm/data/data_sources/suppliers_data_source.dart';
import 'package:hotel_crm/data/data_sources/transactions_data_source.dart';
import 'package:hotel_crm/data/local_database.dart';
import 'package:hotel_crm/data/repositories/material_repo_interface.dart';
import 'package:hotel_crm/data/repositories/suppliers_repo_interface.dart';
import 'package:hotel_crm/data/repositories/transactions_repo_interface.dart';
import 'package:hotel_crm/domain/repositories/materials_repo_impl.dart';
import 'package:hotel_crm/domain/repositories/suppliers_repo_impl.dart';
import 'package:hotel_crm/domain/repositories/transactions_repo_impl.dart';
import 'package:hotel_crm/presentation/bloc/materials/materials_bloc.dart';
import 'package:hotel_crm/presentation/bloc/suppliers/suppliers_bloc.dart';
import 'package:hotel_crm/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:hotel_crm/core/services/pdf_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  registerServices();
  registerDataSources();
  registerRepos();
  registerBlocs();
}

void registerServices() {
  getIt.registerLazySingleton(() => LocalDatabase());
  getIt.registerLazySingleton(() => PdfService());
}

void registerDataSources() {
  getIt.registerLazySingleton(() => MaterialDataSource(db: getIt()));
  getIt.registerLazySingleton(() => SuppliersDataSource(db: getIt()));
  getIt.registerLazySingleton(() => TransactionsDataSource(db: getIt()));
}

void registerRepos() {
  getIt.registerLazySingleton<MaterialRepoInterface>(
    () => MaterialRepoImpl(dataSource: getIt()),
  );
  getIt.registerLazySingleton<SuppliersRepoInterface>(
    () => SuppliersRepoImpl(dataSource: getIt()),
  );
  getIt.registerLazySingleton<TransactionsRepoInterface>(
    () => TransactionsRepoImpl(dataSource: getIt()),
  );
}

void registerBlocs() {
  getIt.registerLazySingleton(() => MaterialsBloc(repo: getIt()));
  getIt.registerLazySingleton(() => SuppliersBloc(repo: getIt()));
  getIt.registerLazySingleton(() => TransactionsBloc(repo: getIt()));
}
