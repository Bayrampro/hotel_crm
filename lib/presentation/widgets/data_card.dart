import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    super.key,
    required this.title,
    required this.children,
    required this.icon,
    this.onTap,
  });

  final String title;
  final List<Widget> children;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
            trailing: Icon(icon),
          ),
        ),
      ),
    );
  }
}
