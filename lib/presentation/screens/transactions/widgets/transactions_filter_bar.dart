import 'package:flutter/material.dart';
import 'package:hotel_crm/domain/entities/material_entity.dart';
import 'package:hotel_crm/domain/entities/supplier_entity.dart';
import 'package:intl/intl.dart';

class TransactionsFilterBar extends StatelessWidget {
  const TransactionsFilterBar({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    this.selectedMaterial,
    required this.allMaterials,
    required this.onMaterialChanged,
    this.selectedSupplier,
    required this.allSuppliers,
    required this.onSupplierChanged,
    required this.onPickDateRange,
    this.selectedDateRange,
  });

  final TextEditingController searchController;
  final void Function(String) onSearchChanged;

  final String? selectedMaterial;
  final List<MaterialEntity> allMaterials;
  final void Function(String?) onMaterialChanged;

  final String? selectedSupplier;
  final List<SupplierEntity> allSuppliers;
  final void Function(String?) onSupplierChanged;

  final void Function() onPickDateRange;
  final DateTimeRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Поиск по комментарию...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: DropdownButtonFormField<String>(
                    // value: selectedMaterial,
                    value:
                        allMaterials.any(
                              (e) => e.id.toString() == selectedMaterial,
                            )
                            ? selectedMaterial
                            : null,

                    isExpanded: true,
                    hint: const Text('Материал'),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Все')),
                      ...allMaterials.map(
                        (entity) => DropdownMenuItem(
                          value: entity.id.toString(),
                          child: Text(entity.name),
                        ),
                      ),
                    ],
                    onChanged: onMaterialChanged,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: DropdownButtonFormField<String>(
                    value:
                        allSuppliers.any(
                              (e) => e.id.toString() == selectedSupplier,
                            )
                            ? selectedSupplier
                            : null,

                    isExpanded: true,
                    hint: const Text('Поставщик'),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Все')),
                      ...allSuppliers.map(
                        (entity) => DropdownMenuItem(
                          value: entity.id.toString(),
                          child: Text(entity.name),
                        ),
                      ),
                    ],
                    onChanged: onSupplierChanged,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: onPickDateRange,
            icon: const Icon(Icons.date_range),
            label: Text(
              selectedDateRange == null
                  ? 'Фильтр по дате'
                  : '${DateFormat.yMMMd().format(selectedDateRange!.start)} — ${DateFormat.yMMMd().format(selectedDateRange!.end)}',
            ),
          ),
          const SizedBox(height: 16),
        ]),
      ),
    );
  }
}
