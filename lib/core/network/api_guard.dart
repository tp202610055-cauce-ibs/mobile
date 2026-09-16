import 'package:dio/dio.dart';

import '../errors/cauce_api_error.dart';
import 'error_mapper.dart';

/// Ejecuta una llamada al backend traduciendo cualquier falla al dominio.
///
/// Es la frontera de los repositorios: hacia adentro hablan `built_value` y
/// `DioException`; hacia afuera, solo tipos del dominio y [CauceApiError].
///
/// Vive en `core/` desde Mobile-2, cumpliendo lo que dejo pedido el acta M29:
/// el helper estaba replicado en `AuthRepository` y en `PatientsRepository`, y
/// el acta fijo que con un tercer repositorio correspondia promoverlo.
/// `IbsSssRepository` fue ese tercero.
///
/// La [FormatException] se atrapa aparte: la lanzan los mapeos cuando el
/// backend responde con exito pero con un cuerpo incompleto. Es una respuesta
/// que el cliente no puede usar, y sin esto escaparia como excepcion cruda
/// hasta la UI.
///
/// [malformedResponseStatus] es el status de esa respuesta exitosa pero
/// inservible, y se informa tal cual en el [UnknownError] resultante: 200 para
/// las lecturas, 201 para las creaciones. Es lo unico que distinguia a las dos
/// copias previas del helper.
Future<T> guardApiCall<T>(
  Future<T> Function() call, {
  int malformedResponseStatus = 200,
}) async {
  try {
    return await call();
  } on DioException catch (error) {
    throw ErrorMapper.map(error);
  } on FormatException catch (error) {
    throw CauceApiError.unknown(
      statusCode: malformedResponseStatus,
      detail: error.message,
    );
  }
}
