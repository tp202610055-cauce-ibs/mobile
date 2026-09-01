/// Tokens del design system de Cauce.
///
/// Fuente de verdad visual: `docs/02-design-system/00-design-system.html`.
/// Los valores de este archivo se transcriben de ese documento y no se
/// inventan. Si el design system cambia, este archivo se actualiza primero y
/// el resto del codigo consume desde aqui.
///
/// Cero colores, tamanos o espaciados literales fuera de este archivo.
library;

import 'package:flutter/widgets.dart';

/// Paleta de color.
///
/// Los ratios de contraste anotados son los que declara el design system,
/// medidos contra el fondo crema [CauceColors.bgPage]. Toda la paleta esta
/// validada WCAG 2.1 AA como minimo.
abstract final class CauceColors {
  // ─── Superficies ───────────────────────────────────────────────────────
  /// Fondo general de la aplicacion. Crema calido.
  static const Color bgPage = Color(0xFFFDFAF6);

  /// Fondo de tarjetas y campos de formulario.
  static const Color bgCard = Color(0xFFFFFFFF);

  /// Fondo de zonas agrupadas dentro de una tarjeta.
  static const Color bgSubtle = Color(0xFFF5EFE6);

  /// Color de divisores y bordes en reposo.
  static const Color bgDivider = Color(0xFFEDE5D7);

  // ─── Texto ─────────────────────────────────────────────────────────────
  /// Texto principal. Contraste 16.6:1, AAA.
  static const Color textPrimary = Color(0xFF1F1A15);

  /// Texto secundario y descripciones. Contraste 8.4:1, AAA.
  static const Color textSecondary = Color(0xFF524A42);

  /// Texto terciario, metadatos y placeholders. Contraste 5.0:1, AA.
  static const Color textTertiary = Color(0xFF6E635A);

  /// Texto sobre superficies de marca saturadas.
  static const Color textOnBrand = Color(0xFFFFFFFF);

  // ─── Marca, coral profundo ─────────────────────────────────────────────
  /// Fondo de realce de marca. Tambien es el anillo de foco de los inputs.
  static const Color brandSoft = Color(0xFFFAECE7);

  /// Color de marca principal. Contraste 7.0:1, AAA.
  static const Color brandBase = Color(0xFF993C1D);

  /// Marca en estado pressed y texto sobre fondos claros. Contraste 9.8:1, AAA.
  static const Color brandStrong = Color(0xFF712B13);

  /// Marca en su variante mas oscura. Contraste 12.5:1, AAA.
  static const Color brandDarkest = Color(0xFF4A1B0C);

  // ─── Clasificacion FODMAP ──────────────────────────────────────────────
  // Sin uso en Mobile-1b. Se transcriben para que el bloque de registro de
  // comidas (Mobile-3) no tenga que volver al HTML del design system.
  static const Color fodmapLowBg = Color(0xFFEAF3DE);
  static const Color fodmapLowText = Color(0xFF27500A);
  static const Color fodmapModerateBg = Color(0xFFFAEEDA);
  static const Color fodmapModerateText = Color(0xFF854F0B);
  static const Color fodmapHighBg = Color(0xFFFCEBEB);
  static const Color fodmapHighText = Color(0xFFA32D2D);

  // ─── Estados semanticos ────────────────────────────────────────────────
  /// Contraste del texto 8.2:1, AAA.
  static const Color successBg = Color(0xFFEAF3DE);
  static const Color successText = Color(0xFF27500A);

  /// Contraste del texto 5.9:1, AA.
  static const Color warningBg = Color(0xFFFAEEDA);
  static const Color warningText = Color(0xFF854F0B);

  /// Contraste del texto 6.1:1, AAA. Es el color de los errores de formulario
  /// y del [CauceErrorBanner].
  static const Color dangerBg = Color(0xFFFCEBEB);
  static const Color dangerText = Color(0xFFA32D2D);

  static const Color infoBg = Color(0xFFE6F1FB);
  static const Color infoText = Color(0xFF0C447C);
}

/// Familias tipograficas y escala de texto.
///
/// El design system fija Inter con dos pesos principales: 400 regular y 500
/// semibold. Base 16px, line-height 1.6 en body para lectura comoda en
/// pacientes adultos.
///
/// Las fuentes se empaquetan como assets en `assets/fonts/`. No se descargan
/// en runtime: el diseno offline-first de Cauce exige que la app renderice
/// identico sin red.
abstract final class CauceTypography {
  /// Familia de interfaz. Declarada en `pubspec.yaml`.
  static const String fontFamilySans = 'Inter';

  /// Familia monoespaciada, para datos tecnicos y codigos.
  static const String fontFamilyMono = 'JetBrainsMono';

  /// Fallbacks del sistema si la familia empaquetada no resolviera.
  static const List<String> fontFamilyFallback = <String>[
    'Roboto',
    'Segoe UI',
    'sans-serif',
  ];

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Escala transcrita del design system. El valor `height` de Flutter es un
  // multiplicador del tamano de fuente, equivalente directo del line-height
  // sin unidad de CSS.

  /// 32px, peso 500, interlineado 1.25. Titulo de pantalla.
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 32,
    fontWeight: medium,
    height: 1.25,
    color: CauceColors.textPrimary,
  );

  /// 24px, peso 500, interlineado 1.3. Encabezado de seccion mayor.
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 24,
    fontWeight: medium,
    height: 1.3,
    color: CauceColors.textPrimary,
  );

  /// 20px, peso 500, interlineado 1.4. Encabezado de seccion.
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 20,
    fontWeight: medium,
    height: 1.4,
    color: CauceColors.textPrimary,
  );

  /// 18px, peso 500, interlineado 1.45. Titulo de tarjeta o item.
  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 18,
    fontWeight: medium,
    height: 1.45,
    color: CauceColors.textPrimary,
  );

  /// 16px, peso 400, interlineado 1.6. Cuerpo de texto por defecto.
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 16,
    fontWeight: regular,
    height: 1.6,
    color: CauceColors.textPrimary,
  );

  /// 14px, peso 400, interlineado 1.55. Texto de apoyo.
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 14,
    fontWeight: regular,
    height: 1.55,
    color: CauceColors.textSecondary,
  );

  /// 16px, peso 500. Etiqueta de boton.
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 16,
    fontWeight: medium,
    color: CauceColors.textPrimary,
  );

  /// 12px, peso 500, tracking 0.3. Caption, badge y timestamp.
  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 12,
    fontWeight: medium,
    letterSpacing: 0.3,
    color: CauceColors.textSecondary,
  );

  /// Monoespaciada 14px. Codigos de invitacion e identificadores tecnicos.
  static const TextStyle mono = TextStyle(
    fontFamily: fontFamilyMono,
    fontSize: 14,
    fontWeight: regular,
    color: CauceColors.textPrimary,
  );
}

/// Escala de espaciado. Base 4px.
///
/// Los nombres siguen la nomenclatura del design system, donde el sufijo es el
/// multiplicador de la base: `space4` son 4 x 4px = 16px.
abstract final class CauceSpacing {
  /// 4px.
  static const double space1 = 4;

  /// 8px.
  static const double space2 = 8;

  /// 12px.
  static const double space3 = 12;

  /// 16px. Padding horizontal estandar de pantalla.
  static const double space4 = 16;

  /// 24px. Separacion entre bloques de un formulario.
  static const double space6 = 24;

  /// 32px.
  static const double space8 = 32;

  /// 48px.
  static const double space12 = 48;
}

/// Radios de borde.
abstract final class CauceRadii {
  /// 8px.
  static const double sm = 8;

  /// 12px. Radio por defecto de componentes: botones e inputs.
  static const double md = 12;

  /// 16px. Tarjetas grandes.
  static const double lg = 16;

  /// 24px.
  static const double xl = 24;

  /// Pill completo, para FAB y badges.
  static const double full = 9999;

  static const BorderRadius borderSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius borderMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius borderLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius borderXl = BorderRadius.all(Radius.circular(xl));
}

/// Grosores de borde y anillo de foco.
abstract final class CauceBorders {
  /// 0.5px. Divisor sutil.
  static const double subtle = 0.5;

  /// 1px. Borde por defecto.
  static const double normal = 1;

  /// 1.5px. Borde de input y de boton secundario.
  static const double strong = 1.5;

  /// 3px. Anillo de foco en [CauceColors.brandSoft].
  static const double focusRing = 3;
}

/// Sombras.
abstract final class CauceElevation {
  /// Sombra unica del design system: `0 2px 8px rgba(31,26,21,0.06)`.
  ///
  /// El color se expresa en ARGB explicito. 0x0F sobre 255 es 0.06.
  static const List<BoxShadow> card = <BoxShadow>[
    BoxShadow(
      color: Color(0x0F1F1A15),
      offset: Offset(0, 2),
      blurRadius: 8,
    ),
  ];
}

/// Medidas de componentes interactivos.
abstract final class CauceSizes {
  /// 48px. Altura minima de area tactil, para botones e inputs por igual.
  ///
  /// El design system la fija como minimo de accesibilidad; coincide con el
  /// objetivo tactil recomendado por Material.
  static const double touchTargetMin = 48;

  /// Padding de boton primario y secundario: 14px vertical, 24px horizontal.
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 14,
  );

  /// Padding de boton terciario, mas ajustado en horizontal.
  static const EdgeInsets buttonPaddingTertiary = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 14,
  );

  /// Padding interno de los campos de texto.
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );

  /// Padding horizontal estandar del contenido de pantalla.
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: CauceSpacing.space4,
  );
}
