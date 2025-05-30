import 'package:flutter/material.dart';
import 'package:hotel_crm/config/theme/app_colors.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  applyElevationOverlayColor: true,
  visualDensity: VisualDensity.standard,
  materialTapTargetSize: MaterialTapTargetSize.padded,
  primaryColor: AppColors.light.primary,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.light.primary),
  scaffoldBackgroundColor: AppColors.light.white,
  extensions: <ThemeExtension<dynamic>>[AppColors.light],
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 22,
      color: AppColors.light.text,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    titleMedium: TextStyle(
      fontSize: 15,
      color: AppColors.light.text,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: AppColors.light.text,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
  ),
);
