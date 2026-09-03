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
}
