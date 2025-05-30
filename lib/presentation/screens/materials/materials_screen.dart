import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_crm/domain/entities/material_entity.dart';
import 'package:hotel_crm/presentation/bloc/materials/materials_bloc.dart';
import 'package:hotel_crm/presentation/widgets/data_card.dart';
import 'package:hotel_crm/presentation/widgets/filter_bar.dart';
import 'package:hotel_crm/presentation/widgets/custom_app_bar.dart';
import 'package:hotel_crm/presentation/widgets/custom_drawer.dart';

class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({super.key});

  @override
  State<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<MaterialEntity> _allMaterials = [];

  String _searchQuery = '';
  String? _selectedName;

  @override
  void initState() {
    super.initState();
    context.read<MaterialsBloc>().add(LoadMaterialsEvent());
  }

  List<MaterialEntity> get _filteredMaterials {
    return _allMaterials.where((m) {
      final matchSearch = m.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final matchDropdown = _selectedName == null || m.name == _selectedName;
      return matchSearch && matchDropdown;
    }).toList();
  }

  void _onFilterChanged(String? value) => setState(() => _selectedName = value);

  void _onSearchChanged(String value) => setState(() => _searchQuery = value);

  void _onMaterialsLoaded(MaterialsLoaded state) {
    setState(() => _allMaterials.addAll(state.materials));
  }

  @override
  Widget build(BuildContext context) {
    final allNames = _allMaterials.map((e) => e.name).toSet().toList();

    return Scaffold(
      drawer: CustomDrawer(),
      body: BlocListener<MaterialsBloc, MaterialsState>(
        listener: (context, state) {
          if (state is MaterialsLoaded) {
            _onMaterialsLoaded(state);
          }
        },
        child: BlocBuilder<MaterialsBloc, MaterialsState>(
          builder: (context, state) {
            if (state is MaterialsLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return CustomScrollView(
                slivers: [
                  CustomAppBar(title: 'Материалы'),
                  SliverToBoxAdapter(
                    child: FilterBar(
                      searchController: _searchController,
                      onSearchChanged: _onSearchChanged,
                      selectedName: _selectedName,
                      onFilterChanged: _onFilterChanged,
                      allNames: allNames,
                    ),
                  ),

                  _filteredMaterials.isEmpty
                      ? const SliverFillRemaining(
                        child: Center(child: Text('Нет совпадений')),
                      )
                      : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final material = _filteredMaterials[index];
                          return DataCard(
                            title: material.name,
                            icon: Icons.inventory_2,
                            children: [
                              const SizedBox(height: 4),
                              Text('Ед. изм: ${material.unitMeasurement}'),
                              Text('Остаток: ${material.currentBalance}'),
                              if (material.description != null)
                                Text('Описание: ${material.description}'),
                            ],
                          );
                        }, childCount: _filteredMaterials.length),
                      ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
