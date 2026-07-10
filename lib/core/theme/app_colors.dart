import 'package:flutter/material.dart';

/// Paleta de colores del design system Cauce.
/// Validada con WCAG 2.1 AA para contraste mínimo 4.5:1 en texto.
class AppColors {
  AppColors._();

  // Primarios
  static const Color primary = Color(0xFF993C1D);
  static const Color primaryDark = Color(0xFF6E2A12);
  static const Color primaryLight = Color(0xFFC65A38);

  // Superficies
  static const Color background = Color(0xFFFDFAF6);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5EFE7);

  // Texto
  static const Color textPrimary = Color(0xFF1F1B16);
  static const Color textSecondary = Color(0xFF5C544A);
  static const Color textOnPrimary = Color(0xFFFDFAF6);
  static const Color textDisabled = Color(0xFFB0A89E);

  // Estados
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFB3261E);
  static const Color warning = Color(0xFFB26A00);
  static const Color info = Color(0xFF1565C0);

  // Bordes y divisores
  static const Color border = Color(0xFFE5DDD0);
  static const Color divider = Color(0xFFEDE6D9);
}