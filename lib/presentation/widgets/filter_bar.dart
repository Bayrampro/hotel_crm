import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    this.selectedName,
    required this.onFilterChanged,
    required this.allNames,
  });

  final TextEditingController searchController;
  final void Function(String) onSearchChanged;

  final String? selectedName;
  final void Function(String?) onFilterChanged;
  final List<String> allNames;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Поиск...',
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
          DropdownButtonFormField<String>(
            value: selectedName,
            onChanged: onFilterChanged,
            decoration: InputDecoration(
              hintText: 'Фильтр',
              prefixIcon: const Icon(Icons.filter_list),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            items: [
              const DropdownMenuItem<String>(value: null, child: Text('Все')),
              ...allNames.map(
                (name) =>
                    DropdownMenuItem<String>(value: name, child: Text(name)),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
