import 'package:flutter/material.dart';

import 'design_tokens.dart';

/// Construye el [ThemeData] de la aplicacion a partir de los tokens de
/// [design_tokens.dart].
///
/// Los widgets no deberian necesitar leer [CauceColors] directamente para lo
/// que el theme ya resuelve. Cuando el theme no alcanza, por ejemplo para los
/// colores semanticos de [CauceErrorBanner], se consume el token explicito.
abstract final class AppTheme {
  /// Theme claro. Es el unico que usa Mobile-1b.
  static ThemeData light() {
    const ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: CauceColors.brandBase,
      onPrimary: CauceColors.textOnBrand,
      primaryContainer: CauceColors.brandSoft,
      onPrimaryContainer: CauceColors.brandDarkest,
      secondary: CauceColors.brandStrong,
      onSecondary: CauceColors.textOnBrand,
      secondaryContainer: CauceColors.bgSubtle,
      onSecondaryContainer: CauceColors.textPrimary,
      surface: CauceColors.bgCard,
      onSurface: CauceColors.textPrimary,
      surfaceContainerHighest: CauceColors.bgSubtle,
      onSurfaceVariant: CauceColors.textSecondary,
      error: CauceColors.dangerText,
      onError: CauceColors.textOnBrand,
      errorContainer: CauceColors.dangerBg,
      onErrorContainer: CauceColors.dangerText,
      outline: CauceColors.bgDivider,
      outlineVariant: CauceColors.bgDivider,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: CauceColors.bgPage,
      fontFamily: CauceTypography.fontFamilySans,
      fontFamilyFallback: CauceTypography.fontFamilyFallback,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      inputDecorationTheme: _inputDecorationTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      checkboxTheme: _checkboxTheme,
      dividerTheme: _dividerTheme,
      iconTheme: _iconTheme,
      progressIndicatorTheme: _progressIndicatorTheme,
      snackBarTheme: _snackBarTheme,
    );
  }

  /// Theme oscuro.
  ///
  /// El design system no define paleta oscura todavia, asi que esto devuelve
  /// el theme claro. La estructura existe para que activar modo oscuro en un
  /// bloque futuro no obligue a tocar `app.dart` ni el router.
  static ThemeData dark() => light();

  // ─── Piezas del theme ──────────────────────────────────────────────────

  static const TextTheme _textTheme = TextTheme(
    displayLarge: CauceTypography.displayLarge,
    headlineLarge: CauceTypography.headlineLarge,
    headlineMedium: CauceTypography.headlineMedium,
    titleLarge: CauceTypography.headlineMedium,
    titleMedium: CauceTypography.titleMedium,
    bodyLarge: CauceTypography.bodyLarge,
    bodyMedium: CauceTypography.bodyMedium,
    labelLarge: CauceTypography.labelLarge,
    labelSmall: CauceTypography.labelSmall,
  );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: CauceColors.bgPage,
    foregroundColor: CauceColors.textPrimary,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    titleTextStyle: CauceTypography.titleMedium,
    iconTheme: IconThemeData(color: CauceColors.textPrimary, size: 24),
  );

  /// Bordes de input: 1.5px en reposo sobre [CauceColors.bgDivider]; en foco
  /// el borde pasa a marca. El anillo de foco de 3px que define el design
  /// system lo dibuja `CauceTextField` en la Fase 8, porque
  /// [InputDecorationTheme] no expresa un box-shadow externo.
  static OutlineInputBorder _inputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: CauceRadii.borderMd,
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    filled: true,
    fillColor: CauceColors.bgCard,
    contentPadding: CauceSizes.inputPadding,
    constraints: const BoxConstraints(
      minHeight: CauceSizes.touchTargetMin,
    ),
    border: _inputBorder(CauceColors.bgDivider, CauceBorders.strong),
    enabledBorder: _inputBorder(CauceColors.bgDivider, CauceBorders.strong),
    focusedBorder: _inputBorder(CauceColors.brandBase, CauceBorders.strong),
    errorBorder: _inputBorder(CauceColors.dangerText, CauceBorders.strong),
    focusedErrorBorder: _inputBorder(
      CauceColors.dangerText,
      CauceBorders.strong,
    ),
    disabledBorder: _inputBorder(
      CauceColors.bgDivider,
      CauceBorders.normal,
    ),
    labelStyle: CauceTypography.bodyMedium,
    floatingLabelStyle: CauceTypography.bodyMedium.copyWith(
      color: CauceColors.brandStrong,
    ),
    hintStyle: CauceTypography.bodyLarge.copyWith(
      color: CauceColors.textTertiary,
    ),
    errorStyle: CauceTypography.labelSmall.copyWith(
      color: CauceColors.dangerText,
    ),
    errorMaxLines: 2,
  );

  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: CauceColors.brandBase,
      foregroundColor: CauceColors.textOnBrand,
      disabledBackgroundColor: CauceColors.bgDivider,
      disabledForegroundColor: CauceColors.textTertiary,
      minimumSize: const Size.fromHeight(CauceSizes.touchTargetMin),
      padding: CauceSizes.buttonPadding,
      elevation: 0,
      textStyle: CauceTypography.labelLarge,
      shape: const RoundedRectangleBorder(
        borderRadius: CauceRadii.borderMd,
      ),
    ).copyWith(
      // El design system marca el estado pressed oscureciendo la marca a
      // brandStrong, no con un overlay translucido.
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return CauceColors.bgDivider;
        }
        if (states.contains(WidgetState.pressed)) {
          return CauceColors.brandStrong;
        }
        return CauceColors.brandBase;
      }),
    ),
  );

  static final OutlinedButtonThemeData _outlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: CauceColors.brandStrong,
      disabledForegroundColor: CauceColors.textTertiary,
      backgroundColor: Colors.transparent,
      minimumSize: const Size.fromHeight(CauceSizes.touchTargetMin),
      padding: CauceSizes.buttonPadding,
      textStyle: CauceTypography.labelLarge,
      side: const BorderSide(
        color: CauceColors.brandBase,
        width: CauceBorders.strong,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: CauceRadii.borderMd,
      ),
    ).copyWith(
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return const BorderSide(
            color: CauceColors.bgDivider,
            width: CauceBorders.strong,
          );
        }
        return const BorderSide(
          color: CauceColors.brandBase,
          width: CauceBorders.strong,
        );
      }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return CauceColors.brandSoft;
        }
        return Colors.transparent;
      }),
    ),
  );

  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: CauceColors.brandBase,
      disabledForegroundColor: CauceColors.textTertiary,
      minimumSize: const Size(0, CauceSizes.touchTargetMin),
      padding: CauceSizes.buttonPaddingTertiary,
      textStyle: CauceTypography.labelLarge,
      shape: const RoundedRectangleBorder(borderRadius: CauceRadii.borderMd),
    ).copyWith(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return CauceColors.brandSoft;
        }
        return Colors.transparent;
      }),
    ),
  );

  static final CheckboxThemeData _checkboxTheme = CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return CauceColors.brandBase;
      }
      return CauceColors.bgCard;
    }),
    checkColor: const WidgetStatePropertyAll<Color>(CauceColors.textOnBrand),
    side: const BorderSide(
      color: CauceColors.textTertiary,
      width: CauceBorders.strong,
    ),
    shape: const RoundedRectangleBorder(borderRadius: CauceRadii.borderSm),
  );

  static const DividerThemeData _dividerTheme = DividerThemeData(
    color: CauceColors.bgDivider,
    thickness: CauceBorders.normal,
    space: CauceSpacing.space4,
  );

  static const IconThemeData _iconTheme = IconThemeData(
    color: CauceColors.textSecondary,
    size: 24,
  );

  static const ProgressIndicatorThemeData _progressIndicatorTheme =
      ProgressIndicatorThemeData(
    color: CauceColors.brandBase,
    circularTrackColor: CauceColors.brandSoft,
  );

  static final SnackBarThemeData _snackBarTheme = SnackBarThemeData(
    backgroundColor: CauceColors.textPrimary,
    contentTextStyle: CauceTypography.bodyMedium.copyWith(
      color: CauceColors.bgPage,
    ),
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(borderRadius: CauceRadii.borderMd),
  );
}
