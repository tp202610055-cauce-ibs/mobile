/// DTO de solicitud de registro alineado al contrato del backend US01.
class RegisterRequestDto {
  final String fullName;
  final String email;
  final String password;
  final String role;
  final bool acceptConsent;

  const RegisterRequestDto({
    required this.fullName,
    required this.email,
    required this.password,
    required this.role,
    required this.acceptConsent,
  });

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'password': password,
    'role': role,
    'acceptConsent': acceptConsent,
  };
}