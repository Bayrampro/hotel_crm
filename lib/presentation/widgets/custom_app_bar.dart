import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, this.leading});

  final String title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: true,
      title: Text(title),
      leading: leading,
      backgroundColor: theme.primaryColor,
      foregroundColor: theme.canvasColor,
      automaticallyImplyLeading: true,
    );
  }
}
