import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_crm/config/router/app_router.dart';
import 'package:hotel_crm/config/theme/app_colors.dart';
import 'package:hotel_crm/domain/entities/material_entity.dart';
import 'package:hotel_crm/domain/entities/supplier_entity.dart';
import 'package:hotel_crm/domain/entities/transaction_entity.dart';
import 'package:hotel_crm/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:hotel_crm/presentation/widgets/custom_app_bar.dart';
import 'package:intl/intl.dart';

class TransactionFormScreen extends StatefulWidget {
  final List<MaterialEntity> allMaterials;
  final List<SupplierEntity> allSuppliers;

  const TransactionFormScreen({
    super.key,
    required this.allMaterials,
    required this.allSuppliers,
  });

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedMaterialId;
  String? selectedSupplierId;
  String? selectedType;
  final _countController = TextEditingController();
  final _commentController = TextEditingController();
  final DateTime _date = DateTime.now();

  @override
  void dispose() {
    _countController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final transaction = TransactionEntity(
        id: 0,
        materialId: int.parse(selectedMaterialId!),
        type: selectedType!,
        count: int.parse(_countController.text.trim()),
        date: _date,
        comment:
            _commentController.text.trim().isEmpty
                ? null
                : _commentController.text.trim(),
        supplierId: int.parse(selectedSupplierId!),
      );

      context.read<TransactionsBloc>().add(
        AddTransactionEvent(transaction: transaction),
      );
    }
  }

  void _onTransactionSuccess(TransactionSuccess state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.msg),
        backgroundColor: context.appColors.success,
      ),
    );
    context.go(Routes.transactions);
  }

  void _onTransactionError(TransactionError state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.msg),
        backgroundColor: context.appColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<TransactionsBloc, TransactionsState>(
        listener: (context, state) {
          if (state is TransactionSuccess) {
            _onTransactionSuccess(state);
          }
          if (state is TransactionError) {
            _onTransactionError(state);
          }
        },
        child: BlocBuilder<TransactionsBloc, TransactionsState>(
          builder: (context, state) {
            if (state is TransactionsLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return CustomScrollView(
                slivers: [
                  CustomAppBar(
                    title: 'Новая операция',
                    leading: IconButton(
                      onPressed: () => context.go(Routes.transactions),
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: selectedMaterialId,
                                hint: const Text('Материал'),
                                items:
                                    widget.allMaterials
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e.id.toString(),
                                            child: Text(e.name),
                                          ),
                                        )
                                        .toList(),
                                onChanged:
                                    (val) => setState(
                                      () => selectedMaterialId = val,
                                    ),
                                validator:
                                    (val) =>
                                        val == null
                                            ? 'Выберите материал'
                                            : null,
                                decoration: _dropdownDecoration(),
                              ),
                              const SizedBox(height: 12),
                              DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: selectedSupplierId,
                                hint: const Text('Поставщик'),
                                items:
                                    widget.allSuppliers
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e.id.toString(),
                                            child: Text(e.name),
                                          ),
                                        )
                                        .toList(),
                                onChanged:
                                    (val) => setState(
                                      () => selectedSupplierId = val,
                                    ),
                                validator:
                                    (val) =>
                                        val == null
                                            ? 'Выберите поставщика'
                                            : null,
                                decoration: _dropdownDecoration(),
                              ),
                              const SizedBox(height: 12),
                              DropdownButtonFormField<String>(
                                value: selectedType,
                                hint: const Text('Тип операции'),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'приход',
                                    child: Text('Приход'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'расход',
                                    child: Text('Расход'),
                                  ),
                                ],
                                onChanged:
                                    (val) => setState(() => selectedType = val),
                                validator:
                                    (val) =>
                                        val == null
                                            ? 'Выберите тип операции'
                                            : null,
                                decoration: _dropdownDecoration(),
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _countController,
                                keyboardType: TextInputType.number,
                                decoration: _inputDecoration('Количество'),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Введите количество';
                                  }
                                  final num = int.tryParse(value.trim());
                                  if (num == null || num < 0) {
                                    return 'Количество должно быть неотрицательным числом';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _commentController,
                                maxLines: 2,
                                decoration: _inputDecoration('Комментарий'),
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Дата: ${DateFormat.yMMMd().format(_date)}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: _submit,
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: context.appColors.white,
                                    backgroundColor: context.appColors.primary,
                                  ),
                                  icon: const Icon(Icons.check),
                                  label: const Text('Сохранить'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) => InputDecoration(
    labelText: label,
    filled: true,
    fillColor: Colors.grey[100],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );

  InputDecoration _dropdownDecoration() => _inputDecoration('');
}
