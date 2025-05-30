import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_crm/domain/entities/material_entity.dart';
import 'package:hotel_crm/domain/entities/supplier_entity.dart';
import 'package:hotel_crm/presentation/screens/materials/materials_screen.dart';
import 'package:hotel_crm/presentation/screens/splash/splash_screen.dart';
import 'package:hotel_crm/presentation/screens/supplier_form/supplier_form_screen.dart';
import 'package:hotel_crm/presentation/screens/suppliers/suppliers_screen.dart';
import 'package:hotel_crm/presentation/screens/transactions/transactions_screen.dart';
import 'package:hotel_crm/presentation/screens/transactions_form/transactions_from_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(path: Routes.splash, builder: (context, state) => SplashScreen()),
      GoRoute(
        path: Routes.materials,
        builder: (context, state) => MaterialsScreen(),
      ),
      GoRoute(
        path: Routes.suppliers,
        builder: (context, state) => SuppliersScreen(),
      ),
      GoRoute(
        path: Routes.suppliersForm,
        builder: (context, state) {
          final supplier =
              state.extra != null ? state.extra as SupplierEntity : null;
          return SupplierFormScreen(supplier: supplier);
        },
      ),
      GoRoute(
        path: Routes.transactions,
        builder: (context, state) => TransactionsScreen(),
      ),
      GoRoute(
        path: Routes.transactionsForm,
        builder: (context, state) {
          final allMaterials =
              (state.extra as Map<String, dynamic>)['allMaterials']
                  as List<MaterialEntity>;
          final allSuppliers =
              (state.extra as Map<String, dynamic>)['allSuppliers']
                  as List<SupplierEntity>;
          return TransactionFormScreen(
            allMaterials: allMaterials,
            allSuppliers: allSuppliers,
          );
        },
      ),
    ],
  );
}

class Routes {
  static const String splash = '/splash';
  static const String materials = '/materials';
  static const String suppliers = '/suppliers';
  static const String suppliersForm = '/suppliers-form';
  static const String transactions = '/transactions';
  static const String transactionsForm = '/transactions-form';
}
