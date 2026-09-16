import '../../l10n/generated/app_localizations.dart';

/// Validaciones de formulario del lado cliente.
///
/// Replican las reglas de FluentValidation del backend para dar respuesta
/// inmediata, sin gastar una peticion ni cupo de rate limit. El backend sigue
/// siendo la autoridad: estas validaciones adelantan el rechazo, no lo
/// sustituyen.
abstract final class Validators {
  /// Formato de correo.
  ///
  /// Deliberadamente permisivo. Un patron estricto rechaza direcciones validas
  /// (dominios con guiones, TLD largos) y el backend valida de todos modos;
  /// el objetivo aca es atrapar el error de tipeo obvio, no ser un RFC 5322.
  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static final RegExp _hasUppercase = RegExp('[A-Z]');
  static final RegExp _hasLowercase = RegExp('[a-z]');
  static final RegExp _hasDigit = RegExp('[0-9]');

  /// Codigo de invitacion: 8 a 20 caracteres, mayusculas y digitos.
  static final RegExp _invitationCode = RegExp(r'^[A-Z0-9]{8,20}$');

  static String? email(String? value, AppLocalizations l10n) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return l10n.validationRequired;
    }
    if (trimmed.length > 150) {
      return l10n.validationEmailTooLong;
    }
    if (!_email.hasMatch(trimmed)) {
      return l10n.validationEmailInvalid;
    }
    return null;
  }

  /// Presencia de contrasena, sin juzgar su forma.
  ///
  /// Es lo que corresponde en el login: exigir alli las reglas de complejidad
  /// le diria al paciente que su contrasena "no es valida" cuando en realidad
  /// la escribio mal, y ademas filtraria el formato de las contrasenas
  /// aceptadas.
  static String? requiredPassword(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.validationRequired;
    }
    return null;
  }

  /// Reglas completas de contrasena, para registro y restablecimiento.
  static String? newPassword(String? value, AppLocalizations l10n) {
    final password = value ?? '';
    if (password.isEmpty) {
      return l10n.validationRequired;
    }
    if (password.length < 8) {
      return l10n.validationPasswordTooShort;
    }
    if (!_hasUppercase.hasMatch(password) ||
        !_hasLowercase.hasMatch(password) ||
        !_hasDigit.hasMatch(password)) {
      return l10n.validationPasswordWeak;
    }
    return null;
  }

  static String? passwordConfirmation(
    String? value,
    String password,
    AppLocalizations l10n,
  ) {
    if (value == null || value.isEmpty) {
      return l10n.validationRequired;
    }
    if (value != password) {
      return l10n.validationPasswordMismatch;
    }
    return null;
  }

  static String? fullName(String? value, AppLocalizations l10n) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return l10n.validationRequired;
    }
    if (trimmed.length < 2 || trimmed.length > 150) {
      return l10n.validationFullNameLength;
    }
    return null;
  }

  /// El codigo de invitacion es opcional: vacio es valido.
  static String? invitationCode(String? value, AppLocalizations l10n) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return null;
    }
    if (!_invitationCode.hasMatch(trimmed)) {
      return l10n.validationInvitationCodeFormat;
    }
    return null;
  }

  // ─── Perfil clinico (US03) ─────────────────────────────────────────────
  //
  // Los rangos replican las invariantes de la entidad `PatientProfile` del
  // backend, no las de FluentValidation. El backend las verifica en el dominio
  // y las reporta con `invalid_biometric_value`, un error que **no trae
  // `errors` por campo**: solo un mensaje en prosa. Sin estas validaciones
  // locales, el paciente recibiria un aviso que no le dice cual de los cuatro
  // campos esta mal.

  /// Edad minima del piloto, en anios cumplidos.
  static const int minAge = 18;

  /// Edad maxima admitida.
  static const int maxAge = 120;

  /// Limites de peso, exclusivos en los dos extremos.
  static const double minWeightKg = 0;
  static const double maxWeightKg = 500;

  /// Limites de estatura, exclusivos en los dos extremos.
  static const double minHeightCm = 0;
  static const double maxHeightCm = 250;

  static const int maxMedicationsLength = 1000;
  static const int maxAllergyNotesLength = 500;

  /// Fecha de nacimiento: obligatoria, no futura, y con edad entre 18 y 120.
  ///
  /// [today] se inyecta para que los tests no dependan del reloj real. La edad
  /// se calcula en anios cumplidos, igual que `PatientProfile.ComputeAge`.
  static String? dateOfBirth(
    DateTime? value,
    AppLocalizations l10n, {
    DateTime? today,
  }) {
    if (value == null) {
      return l10n.validationRequired;
    }

    final reference = _dateOnly(today ?? DateTime.now());
    final birth = _dateOnly(value);

    if (birth.isAfter(reference)) {
      return l10n.validationDateOfBirthFuture;
    }

    final age = _yearsBetween(birth, reference);
    if (age < minAge || age > maxAge) {
      return l10n.validationAgeOutOfRange(minAge, maxAge);
    }
    return null;
  }

  /// Fecha de diagnostico: opcional, pero nunca futura.
  static String? diagnosisDate(
    DateTime? value,
    AppLocalizations l10n, {
    DateTime? today,
  }) {
    if (value == null) {
      return null;
    }
    final reference = _dateOnly(today ?? DateTime.now());
    if (_dateOnly(value).isAfter(reference)) {
      return l10n.validationDiagnosisDateFuture;
    }
    return null;
  }

  /// Peso en kilogramos. Mayor que 0 y menor que 500, sin incluir los bordes.
  static String? weightKg(String? value, AppLocalizations l10n) {
    return _biometric(
      value,
      l10n,
      min: minWeightKg,
      max: maxWeightKg,
      outOfRange: l10n.validationWeightOutOfRange,
    );
  }

  /// Estatura en centimetros. Mayor que 0 y menor que 250, sin los bordes.
  static String? heightCm(String? value, AppLocalizations l10n) {
    return _biometric(
      value,
      l10n,
      min: minHeightCm,
      max: maxHeightCm,
      outOfRange: l10n.validationHeightOutOfRange,
    );
  }

  /// Medicacion declarada: opcional, con tope de longitud.
  static String? medications(String? value, AppLocalizations l10n) {
    return _optionalLength(value, maxMedicationsLength, l10n);
  }

  /// Nota de una alergia declarada: opcional, con tope de longitud.
  static String? allergyNotes(String? value, AppLocalizations l10n) {
    return _optionalLength(value, maxAllergyNotesLength, l10n);
  }

  /// Valida un valor biometrico tipeado como texto.
  ///
  /// Acepta coma o punto como separador decimal: el teclado numerico de
  /// Android en es_PE ofrece coma, y rechazar "70,5" seria rechazar lo que el
  /// teclado mismo propone.
  static String? _biometric(
    String? value,
    AppLocalizations l10n, {
    required double min,
    required double max,
    required String outOfRange,
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return l10n.validationRequired;
    }

    final parsed = double.tryParse(trimmed.replaceAll(',', '.'));
    if (parsed == null) {
      return l10n.validationNumberInvalid;
    }
    // Bordes exclusivos, igual que el backend: `is <= Min or >= Max`.
    if (parsed <= min || parsed >= max) {
      return outOfRange;
    }
    return null;
  }

  static String? _optionalLength(
    String? value,
    int maxLength,
    AppLocalizations l10n,
  ) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return null;
    }
    if (trimmed.length > maxLength) {
      return l10n.validationTextTooLong(maxLength);
    }
    return null;
  }

  /// Descarta la hora para comparar solo fechas.
  static DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  /// Anios cumplidos entre dos fechas.
  static int _yearsBetween(DateTime from, DateTime to) {
    var years = to.year - from.year;
    // Todavia no cumplio anios este ano.
    if (to.month < from.month ||
        (to.month == from.month && to.day < from.day)) {
      years--;
    }
    return years;
  }
}
