/// DTO de respuesta de los endpoints /auth/register y /auth/login.
class AuthResponseDto {
  final String accessToken;
  final String userId;
  final String email;
  final String fullName;
  final String role;
  final DateTime expiresAt;

  const AuthResponseDto({
    required this.accessToken,
    required this.userId,
    required this.email,
    required this.fullName,
    required this.role,
    required this.expiresAt,
  });

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthResponseDto(
      accessToken: json['accessToken'] as String,
      userId: json['userId'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      role: json['role'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );
  }
}