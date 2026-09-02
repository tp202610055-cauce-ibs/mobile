// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticated_user_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthenticatedUserSnapshotImpl _$$AuthenticatedUserSnapshotImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthenticatedUserSnapshotImpl(
      userId: json['userId'] as String,
      keycloakId: json['keycloakId'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      fullName: json['fullName'] as String,
      emailVerified: json['emailVerified'] as bool,
      isInActivePilot: json['isInActivePilot'] as bool,
    );

Map<String, dynamic> _$$AuthenticatedUserSnapshotImplToJson(
        _$AuthenticatedUserSnapshotImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'keycloakId': instance.keycloakId,
      'email': instance.email,
      'role': instance.role,
      'fullName': instance.fullName,
      'emailVerified': instance.emailVerified,
      'isInActivePilot': instance.isInActivePilot,
    };
