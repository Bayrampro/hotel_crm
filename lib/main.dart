import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_crm/config/router/app_router.dart';
import 'package:hotel_crm/config/theme/app_theme.dart';
import 'package:hotel_crm/core/di/setup_locator.dart';
import 'package:hotel_crm/presentation/bloc/materials/materials_bloc.dart';
import 'package:hotel_crm/presentation/bloc/suppliers/suppliers_bloc.dart';
import 'package:hotel_crm/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  setupLocator();
  runApp(const HotelCrm());
}

class HotelCrm extends StatelessWidget {
  const HotelCrm({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<MaterialsBloc>()),
        BlocProvider(create: (context) => getIt.get<SuppliersBloc>()),
        BlocProvider(create: (context) => getIt.get<TransactionsBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Mini Hotel Crm',
        theme: appTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
