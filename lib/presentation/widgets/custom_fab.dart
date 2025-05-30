import 'package:flutter/material.dart';
import 'package:hotel_crm/config/theme/app_colors.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: context.appColors.buttonPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      child: Icon(Icons.add, color: context.appColors.white),
    );
  }
}
