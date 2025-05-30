import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_crm/config/router/app_router.dart';
import 'package:hotel_crm/domain/entities/supplier_entity.dart';
import 'package:hotel_crm/presentation/bloc/suppliers/suppliers_bloc.dart';
import 'package:hotel_crm/presentation/widgets/custom_fab.dart';
import 'package:hotel_crm/presentation/widgets/data_card.dart';
import 'package:hotel_crm/presentation/widgets/filter_bar.dart';
import 'package:hotel_crm/presentation/widgets/custom_drawer.dart';
import 'package:hotel_crm/presentation/widgets/custom_app_bar.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<SupplierEntity> _allSuppliers = [];

  String _searchQuery = '';
  String? _selectedName;

  @override
  void initState() {
    super.initState();
    context.read<SuppliersBloc>().add(LoadSuppliersEvent());
  }

  List<SupplierEntity> get _filteredSuppliers {
    return _allSuppliers.where((s) {
      final query = _searchQuery.toLowerCase();
      final matchSearch =
          s.name.toLowerCase().contains(query) ||
          s.contactPerson.toLowerCase().contains(query) ||
          s.phone.toLowerCase().contains(query) ||
          (s.email?.toLowerCase().contains(query) ?? false) ||
          (s.address?.toLowerCase().contains(query) ?? false);

      final matchDropdown = _selectedName == null || s.name == _selectedName;
      return matchSearch && matchDropdown;
    }).toList();
  }

  void _onFilterChanged(String? value) => setState(() => _selectedName = value);

  void _onSearchChanged(String value) => setState(() => _searchQuery = value);

  void _onSuppliersLoaded(SuppliersLoaded state) {
    setState(() => _allSuppliers.addAll(state.suppliers));
  }

  @override
  Widget build(BuildContext context) {
    final allNames = _allSuppliers.map((e) => e.name).toSet().toList();

    return Scaffold(
      drawer: const CustomDrawer(),
      body: BlocListener<SuppliersBloc, SuppliersState>(
        listener: (context, state) {
          if (state is SuppliersLoaded) {
            _onSuppliersLoaded(state);
          }
        },
        child: BlocBuilder<SuppliersBloc, SuppliersState>(
          builder: (context, state) {
            if (state is SuppliersLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return CustomScrollView(
                slivers: [
                  const CustomAppBar(title: 'Поставщики'),
                  SliverToBoxAdapter(
                    child: FilterBar(
                      searchController: _searchController,
                      onSearchChanged: _onSearchChanged,
                      selectedName: _selectedName,
                      onFilterChanged: _onFilterChanged,
                      allNames: allNames,
                    ),
                  ),

                  _filteredSuppliers.isEmpty
                      ? const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(child: Text('Нет совпадений')),
                      )
                      : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: _filteredSuppliers.length,
                          (context, index) {
                            final supplier = _filteredSuppliers[index];
                            return DataCard(
                              onTap:
                                  () => context.go(
                                    Routes.suppliersForm,
                                    extra: supplier,
                                  ),
                              title: supplier.name,
                              icon: Icons.local_shipping,
                              children: [
                                Text('Контакт: ${supplier.contactPerson}'),
                                Text('Телефон: ${supplier.phone}'),
                                if (supplier.email != null)
                                  Text('Email: ${supplier.email}'),
                                if (supplier.address != null)
                                  Text('Адрес: ${supplier.address}'),
                              ],
                            );
                          },
                        ),
                      ),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFAB(
        onPressed: () => context.go(Routes.suppliersForm),
      ),
    );
  }
}
