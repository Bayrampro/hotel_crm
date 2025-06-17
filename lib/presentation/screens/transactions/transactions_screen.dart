import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_crm/config/router/app_router.dart';
import 'package:hotel_crm/config/theme/app_colors.dart';
import 'package:hotel_crm/core/di/setup_locator.dart';
import 'package:hotel_crm/core/services/pdf_service.dart';
import 'package:hotel_crm/domain/entities/material_entity.dart';
import 'package:hotel_crm/domain/entities/supplier_entity.dart';
import 'package:hotel_crm/presentation/bloc/materials/materials_bloc.dart';
import 'package:hotel_crm/presentation/bloc/suppliers/suppliers_bloc.dart';
import 'package:hotel_crm/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:hotel_crm/presentation/screens/transactions/widgets/transactions_filter_bar.dart';
import 'package:hotel_crm/presentation/widgets/custom_app_bar.dart';
import 'package:hotel_crm/presentation/widgets/custom_drawer.dart';
import 'package:hotel_crm/presentation/widgets/custom_fab.dart';
import 'package:intl/intl.dart';
import 'package:hotel_crm/domain/entities/transaction_entity.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedMaterial;
  String? _selectedSupplier;
  DateTimeRange? _selectedDateRange;

  final List<TransactionEntity> _allTransactions = [];
  final List<MaterialEntity> _allMaterials = [];
  final List<SupplierEntity> _allSuppliers = [];

  @override
  void initState() {
    super.initState();
    context.read<TransactionsBloc>().add(LoadTransactionsEvent());
    context.read<MaterialsBloc>().add(LoadMaterialsEvent());
    context.read<SuppliersBloc>().add(LoadSuppliersEvent());
  }

  List<TransactionEntity> get _filteredTransactions {
    return _allTransactions.where((t) {
      final matchQuery =
          _searchQuery.isEmpty ||
          (t.comment?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false);

      t.comment?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false;
      final matchMaterial =
          _selectedMaterial == null ||
          t.materialId.toString() == _selectedMaterial;
      final matchSupplier =
          _selectedSupplier == null ||
          t.supplierId.toString() == _selectedSupplier;

      final matchDate =
          _selectedDateRange == null ||
          (t.date.isAfter(
                _selectedDateRange!.start.subtract(const Duration(days: 1)),
              ) &&
              t.date.isBefore(
                _selectedDateRange!.end.add(const Duration(days: 1)),
              ));

      return matchQuery && matchMaterial && matchSupplier && matchDate;
    }).toList();
  }

  void _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: _selectedDateRange,
    );
    if (picked != null) {
      setState(() => _selectedDateRange = picked);
    }
  }

  void _onSupplierChanged(String? val) =>
      setState(() => _selectedSupplier = val);

  void _onMaterialChanged(String? val) =>
      setState(() => _selectedMaterial = val);

  void _onSearchChanged(String v) => setState(() => _searchQuery = v);

  void _onTransactionsLoaded(TransactionsLoaded state) {
    setState(() => _allTransactions.addAll(state.transactions));
    log(_allTransactions.toString());
  }

  void _onMaterialsLoaded(MaterialsLoaded state) {
    final loadedIds = state.materials.map((m) => m.id.toString()).toSet();
    setState(() {
      _allMaterials.clear();
      _allMaterials.addAll(state.materials);

      if (_selectedMaterial != null && !loadedIds.contains(_selectedMaterial)) {
        _selectedMaterial = null;
      }
    });
  }

  void _onSuppliersLoaded(SuppliersLoaded state) {
    final loadedIds = state.suppliers.map((s) => s.id.toString()).toSet();
    setState(() {
      _allSuppliers.clear();
      _allSuppliers.addAll(state.suppliers);

      if (_selectedSupplier != null && !loadedIds.contains(_selectedSupplier)) {
        _selectedSupplier = null;
      }
    });
  }

  void _generatePdf(TransactionEntity transaction) async {
    final material = _allMaterials.firstWhere((m) => m.id == transaction.materialId);
    final supplier = _allSuppliers.firstWhere((s) => s.id == transaction.supplierId);
    
    try {
      await getIt<PdfService>().generateOperationPdf(
        transaction: transaction,
        material: material,
        supplier: supplier,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Platform.isWindows 
                ? 'PDF сохранен в папке Документы/HotelCRM_PDFs'
                : Platform.isMacOS
                  ? 'PDF сгенерирован и открыт в Preview'
                  : 'PDF готов к печати'
            ),
            backgroundColor: context.appColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при генерации PDF: $e'),
            backgroundColor: context.appColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: BlocListener<TransactionsBloc, TransactionsState>(
        listener: (context, state) {
          if (state is TransactionsLoaded) {
            _onTransactionsLoaded(state);
          }
        },
        child: BlocListener<MaterialsBloc, MaterialsState>(
          listener: (context, state) {
            if (state is MaterialsLoaded) {
              _onMaterialsLoaded(state);
            }
          },
          child: BlocListener<SuppliersBloc, SuppliersState>(
            listener: (context, state) {
              if (state is SuppliersLoaded) {
                _onSuppliersLoaded(state);
              }
            },
            child: CustomScrollView(
              slivers: [
                CustomAppBar(title: 'Операции'),
                TransactionsFilterBar(
                  searchController: _searchController,
                  onSearchChanged: _onSearchChanged,
                  selectedMaterial: _selectedMaterial,
                  allMaterials: _allMaterials,
                  onMaterialChanged: _onMaterialChanged,
                  selectedSupplier: _selectedSupplier,
                  allSuppliers: _allSuppliers,
                  onSupplierChanged: _onSupplierChanged,
                  selectedDateRange: _selectedDateRange,
                  onPickDateRange: _pickDateRange,
                ),
                _filteredTransactions.isEmpty
                    ? const SliverFillRemaining(
                      child: Center(child: Text('Нет операций')),
                    )
                    : SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final t = _filteredTransactions[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          child: ListTile(
                            leading: Icon(
                              t.type == 'приход'
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color:
                                  t.type == 'приход'
                                      ? context.appColors.success
                                      : context.appColors.error,
                            ),
                            title: Text('${t.type.toUpperCase()} — ${t.count}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Дата: ${DateFormat.yMMMd().add_Hm().format(t.date)}',
                                ),
                                if (t.comment != null)
                                  Text('Комментарий: ${t.comment}'),
                                Text(
                                  'Материал ID: ${t.materialId} | Поставщик ID: ${t.supplierId}',
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.picture_as_pdf),
                              onPressed: () => _generatePdf(t),
                              tooltip: 'Сгенерировать PDF',
                            ),
                          ),
                        );
                      }, childCount: _filteredTransactions.length),
                    ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFAB(
        onPressed:
            () => context.go(
              Routes.transactionsForm,
              extra: {
                'allMaterials': _allMaterials,
                'allSuppliers': _allSuppliers,
              },
            ),
      ),
    );
  }
}
