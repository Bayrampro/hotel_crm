import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_crm/config/router/app_router.dart';
import 'package:hotel_crm/config/theme/app_colors.dart';
import 'package:hotel_crm/domain/entities/supplier_entity.dart';
import 'package:hotel_crm/presentation/bloc/suppliers/suppliers_bloc.dart';
import 'package:hotel_crm/presentation/widgets/custom_app_bar.dart';

class SupplierFormScreen extends StatefulWidget {
  final SupplierEntity? supplier;

  const SupplierFormScreen({super.key, this.supplier});

  @override
  State<SupplierFormScreen> createState() => _SupplierFormScreenState();
}

class _SupplierFormScreenState extends State<SupplierFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _contactPersonController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;

  bool get isEdit => widget.supplier != null;

  @override
  void initState() {
    super.initState();
    final supplier = widget.supplier;
    _nameController = TextEditingController(text: supplier?.name ?? '');
    _contactPersonController = TextEditingController(
      text: supplier?.contactPerson ?? '',
    );
    _phoneController = TextEditingController(text: supplier?.phone ?? '');
    _emailController = TextEditingController(text: supplier?.email ?? '');
    _addressController = TextEditingController(text: supplier?.address ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactPersonController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final supplier = SupplierEntity(
        id: widget.supplier?.id ?? 0,
        name: _nameController.text.trim(),
        contactPerson: _contactPersonController.text.trim(),
        phone: _phoneController.text.trim(),
        email:
            _emailController.text.trim().isEmpty
                ? null
                : _emailController.text.trim(),
        address:
            _addressController.text.trim().isEmpty
                ? null
                : _addressController.text.trim(),
        createdAt: widget.supplier?.createdAt ?? DateTime.now(),
      );

      if (isEdit) {
        // await supplierRepository.update(supplier);
        debugPrint('Изменён: $supplier');
        context.read<SuppliersBloc>().add(
          UpdateSuppliersEvent(supplier: supplier),
        );
      } else {
        // await supplierRepository.insert(supplier);
        debugPrint('Добавлен: $supplier');
        context.read<SuppliersBloc>().add(
          AddSuppliersEvent(supplier: supplier),
        );
      }

      // Navigator.pop(context, supplier);
    }
  }

  void _onSuppliersSuccess(SuppliersSuccess state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.msg),
        backgroundColor: context.appColors.success,
      ),
    );
    context.go(Routes.suppliers);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SuppliersBloc, SuppliersState>(
      listener: (context, state) {
        if (state is SuppliersSuccess) {
          _onSuppliersSuccess(state);
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomAppBar(
              leading: IconButton(
                onPressed: () => context.go(Routes.suppliers),
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: isEdit ? 'Редактировать поставщика' : 'Новый поставщик',
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildField(_nameController, 'Название', required: true),
                      _buildField(
                        _contactPersonController,
                        'Контактное лицо',
                        required: true,
                      ),
                      _buildField(_phoneController, 'Телефон', required: true),
                      _buildField(_emailController, 'Email'),
                      _buildField(_addressController, 'Адрес'),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _submit,
                          icon: Icon(isEdit ? Icons.save : Icons.add),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.appColors.buttonPrimary,
                            foregroundColor: context.appColors.white,
                          ),
                          label: Text(
                            isEdit ? 'Сохранить изменения' : 'Добавить',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label, {
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (required && (value == null || value.trim().isEmpty)) {
            return 'Поле "$label" обязательно';
          }
          return null;
        },
      ),
    );
  }
}
