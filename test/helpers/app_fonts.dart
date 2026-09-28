import 'dart:io';

import 'package:cauce_mobile/core/theme/design_tokens.dart';
import 'package:flutter/services.dart';

/// Carga Inter, la tipografia de la app, en el entorno de test.
///
/// `flutter_test` dibuja con una fuente de prueba en la que cada glifo es un
/// cuadrado del tamano de la letra: "Pendiente de sincronizar" mide ahi el
/// doble que en el celular. Un test que verifique que un texto **entra** en
/// un ancho real necesita las metricas reales, o da rojo por algo que en el
/// dispositivo no pasa (acta M49).
///
/// Lee los `.ttf` del disco y no del bundle: en test el bundle no expone las
/// fuentes declaradas en el `pubspec`.
Future<void> loadAppFonts() async {
  final loader = FontLoader(CauceTypography.fontFamilySans);
  for (final weight in <String>['Regular', 'Medium', 'SemiBold']) {
    final bytes =
        File('assets/fonts/inter/Inter-$weight.ttf').readAsBytesSync();
    loader.addFont(Future<ByteData>.value(ByteData.sublistView(bytes)));
  }
  await loader.load();
}
