import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_crm/config/router/app_router.dart';
import 'package:hotel_crm/config/theme/app_colors.dart';
import 'package:hotel_crm/core/consts/constans.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: context.appColors.primary),
            child: Center(child: Image.asset(Assets.logoPath)),
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text('Материалы'),
            onTap: () => context.go(Routes.materials),
          ),
          ListTile(
            leading: Icon(Icons.local_shipping),
            title: Text('Поставщики'),
            onTap: () => context.go(Routes.suppliers),
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Операции'),
            onTap: () => context.go(Routes.transactions),
          ),
        ],
      ),
    );
  }
}
