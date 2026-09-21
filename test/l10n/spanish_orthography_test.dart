import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Ortografia del castellano en `app_es.arb`.
///
/// **Existe por lo que vio un evaluador antes que nosotros.** Hasta
/// Mobile-3.2 la pantalla de login decia "Contrasena", "Inicia sesion" y
/// "No tienes cuenta?", porque los textos de Mobile-1b se escribieron sin
/// tildes y nadie los volvio a mirar. Son 65 cadenas que el paciente lee
/// todos los dias.
///
/// El test no corrige: impide la reincidencia. Si alguien agrega una cadena
/// con una de estas formas, se pone rojo antes de llegar al celular.

/// Palabras que en castellano **siempre** llevan tilde o enie.
///
/// Deliberadamente corta y conservadora. Quedan fuera `esta`, `mas`, `solo`,
/// `aun`, `activo`, `valido` y `practica`, que existen con y sin tilde y
/// significan cosas distintas: incluirlas produciria falsos rojos sobre
/// frases correctas.
///
/// Tampoco van los plurales de las palabras en `-cion`: en castellano
/// `opcion` pasa a `opciones` y **pierde** la tilde, asi que listarlos daria
/// rojo sobre texto correcto. Si van los plurales que la conservan, como
/// `contrasenas` y `lineas`, que es justo el caso que se colo la primera vez
/// que corrio este test.
const List<String> _alwaysAccented = <String>[
  'sesion',
  'contrasena',
  'contrasenas',
  'electronico',
  'informacion',
  'sincronizacion',
  'aqui',
  'dia',
  'dias',
  'anios',
  'numero',
  'numeros',
  'codigo',
  'telefono',
  'proximo',
  'proxima',
  'ultimo',
  'ultima',
  'ultimos',
  'ultimas',
  'categoria',
  'categorias',
  'sintoma',
  'sintomas',
  'clinico',
  'clinica',
  'clinicos',
  'clinicas',
  'linea',
  'lineas',
  'descripcion',
  'validacion',
  'confirmacion',
  'verificacion',
  'recuperacion',
  'opcion',
  'seleccion',
  'accion',
  'conexion',
  'version',
  'direccion',
  'duracion',
  'evaluacion',
  'evolucion',
  'medicacion',
  'porcion',
  'posicion',
  'relacion',
  'revision',
  'solucion',
  'estimacion',
  'composicion',
  'reduccion',
  'nutricion',
  'tambien',
  'segun',
  'despues',
  'ademas',
  'asi',
  'facil',
  'dificil',
  'rapido',
  'rapida',
  'automatico',
  'minimo',
  'maximo',
  'basico',
  'publico',
  'medico',
  'energia',
  'energias',
  'deberia',
  'podria',
  'tendria',
  'habria',
  'comunicate',
  'todavia',
  'ningun',
  'algun',
  'tamano',
];

void main() {
  late Map<String, String> textos;

  setUpAll(() {
    final raw = File('lib/l10n/app_es.arb').readAsStringSync();
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    textos = <String, String>{
      for (final entry in decoded.entries)
        if (!entry.key.startsWith('@') && entry.value is String)
          entry.key: entry.value as String,
    };
  });

  test('el arb se lee como UTF-8 y no tiene caracteres de reemplazo', () {
    // Una edicion desde una consola con la pagina de codigos equivocada
    // convierte las tildes en basura silenciosa.
    for (final entry in textos.entries) {
      expect(
        entry.value.contains('\uFFFD'),
        isFalse,
        reason: '${entry.key} tiene un caracter de reemplazo: se corrompio '
            'la codificacion al editarlo',
      );
    }
  });

  test('ninguna cadena usa formas sin tilde', () {
    final fallas = <String>[];

    for (final entry in textos.entries) {
      // Los marcadores simples se quitan antes de partir en palabras:
      // `{version}` es el nombre de un parametro, no la palabra castellana.
      // Las estructuras ICU (`{count, plural, ...}`) no matchean y su texto
      // interno si se revisa, que es lo que se quiere.
      final palabras = entry.value
          .replaceAll(RegExp(r'\{[a-zA-Z][a-zA-Z0-9_]*\}'), ' ')
          .toLowerCase()
          .split(RegExp(r'[^0-9a-záéíóúüñ]+'))
          .where((word) => word.isNotEmpty);

      for (final palabra in palabras) {
        if (_alwaysAccented.contains(palabra)) {
          fallas.add('${entry.key}: "${entry.value}" usa "$palabra"');
        }
      }
    }

    expect(
      fallas,
      isEmpty,
      reason: 'Estas cadenas van sin tilde o sin enie:\n${fallas.join('\n')}',
    );
  });

  test('las preguntas abren con el signo de interrogacion', () {
    final fallas = <String>[
      for (final entry in textos.entries)
        if (entry.value.contains('?') && !entry.value.contains('¿'))
          '${entry.key}: "${entry.value}"',
    ];

    expect(
      fallas,
      isEmpty,
      reason: 'Al castellano le falta el signo de apertura:\n'
          '${fallas.join('\n')}',
    );
  });

  test('las exclamaciones abren con el signo correspondiente', () {
    final fallas = <String>[
      for (final entry in textos.entries)
        if (entry.value.contains('!') && !entry.value.contains('¡'))
          '${entry.key}: "${entry.value}"',
    ];

    expect(fallas, isEmpty, reason: fallas.join('\n'));
  });
}
