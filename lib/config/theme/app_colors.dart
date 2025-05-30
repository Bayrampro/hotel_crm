import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.background,
    required this.text,
    required this.backgroundTextField,
    required this.border,
    required this.link,
    required this.secondaryText,
    required this.buttonPrimary,
    required this.buttonText,
    required this.buttonHover,
    required this.error,
    required this.success,
    required this.darkBackground,
    required this.containerBG,
    required this.buttonBG,
    required this.docContainer,
    required this.white,
    required this.black,
    required this.f8f8f8,
  });
  final Color primary;
  final Color background;
  final Color text;
  final Color backgroundTextField;
  final Color border;
  final Color link;
  final Color secondaryText;
  final Color buttonPrimary;
  final Color buttonText;
  final Color buttonHover;
  final Color error;
  final Color success;
  final Color darkBackground;
  final Color containerBG;
  final Color buttonBG;
  final Color docContainer;
  final Color white;
  final Color black;
  final Color f8f8f8;
  //светлая тема
  static const light = AppColors(
    primary: Color(0xFF29EB4C),
    background: Color(0xFFF9FAFB),
    text: Color(0xFF111827),
    backgroundTextField: Color(0xFFE7EAEC),
    border: Color(0xFF50C878),
    link: Color(0xFF50C878),
    secondaryText: Color(0xFF6B7280),
    buttonText: Color(0xFFFFFFFF),
    buttonPrimary: Color(0xFF29EB4C),
    buttonHover: Color(0xFF2BA200),
    error: Color(0xFFDC2626),
    success: Color(0xFF16A34A),
    darkBackground: Color(0xFF1F2937),
    containerBG: Color(0xFFE7EAEC),
    buttonBG: Color(0xFFE7EAEC),
    docContainer: Color(0xFFFFF4CC),
    white: Colors.white,
    black: Colors.black,
    f8f8f8: Color(0xFFF8F8F8),
  );

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? background,
    Color? text,
    Color? backgroundTextField,
    Color? border,
    Color? link,
    Color? secondaryText,
    Color? buttonText,
    Color? buttonPrimary,
    Color? buttonHover,
    Color? error,
    Color? success,
    Color? darkBackground,
    Color? containerBG,
    Color? buttonBG,
    Color? docContainer,
    Color? white,
    Color? black,
    Color? f8f8f8,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      text: text ?? this.text,
      backgroundTextField: backgroundTextField ?? this.backgroundTextField,
      border: border ?? this.border,
      link: link ?? this.link,
      secondaryText: secondaryText ?? this.secondaryText,
      buttonPrimary: buttonPrimary ?? this.buttonPrimary,
      buttonText: buttonText ?? this.buttonText,
      buttonHover: buttonHover ?? this.buttonHover,
      error: error ?? this.error,
      success: success ?? this.success,
      darkBackground: darkBackground ?? this.darkBackground,
      containerBG: containerBG ?? this.containerBG,
      buttonBG: buttonBG ?? this.buttonBG,
      docContainer: docContainer ?? this.docContainer,
      white: white ?? this.white,
      black: black ?? this.black,
      f8f8f8: f8f8f8 ?? this.f8f8f8,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      text: Color.lerp(text, other.text, t)!,
      backgroundTextField:
          Color.lerp(backgroundTextField, other.backgroundTextField, t)!,
      border: Color.lerp(border, other.border, t)!,
      link: Color.lerp(link, other.link, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      buttonPrimary: Color.lerp(buttonPrimary, other.buttonPrimary, t)!,
      buttonText: Color.lerp(buttonText, other.buttonText, t)!,
      buttonHover: Color.lerp(buttonHover, other.buttonHover, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      darkBackground: Color.lerp(darkBackground, other.darkBackground, t)!,
      containerBG: Color.lerp(containerBG, other.containerBG, t)!,
      buttonBG: Color.lerp(buttonBG, other.buttonBG, t)!,
      docContainer: Color.lerp(docContainer, other.docContainer, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      f8f8f8: Color.lerp(f8f8f8, other.f8f8f8, t)!,
    );
  }
}

extension BuildContextX on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
