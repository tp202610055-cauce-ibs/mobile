/// DTO del endpoint GET /api/v1/users/me.
class UserProfileDto {
  final String userId;
  final String fullName;
  final String email;
  final bool emailVerified;
  final String role;
  final String status;
  final DateTime createdAt;
  final DateTime? lastLoginAt;

  const UserProfileDto({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.emailVerified,
    required this.role,
    required this.status,
    required this.createdAt,
    this.lastLoginAt,
  });

  factory UserProfileDto.fromJson(Map<String, dynamic> json) {
    return UserProfileDto(
      userId: json['userId'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      emailVerified: json['emailVerified'] as bool,
      role: json['role'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'] as String)
          : null,
    );
  }
}