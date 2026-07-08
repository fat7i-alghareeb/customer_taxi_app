class UserEntity {
  const UserEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profilePhotoUrl,
    this.isPhoneVerified = true,
    this.isEmailVerified = false,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? profilePhotoUrl;

  /// False for Google/email accounts that entered a phone but skipped SMS
  /// verification. Drives the persistent "verify your phone" warning.
  final bool isPhoneVerified;
  final bool isEmailVerified;

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profilePhotoUrl,
    bool? isPhoneVerified,
    bool? isEmailVerified,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'profilePhotoUrl': profilePhotoUrl,
        'isPhoneVerified': isPhoneVerified,
        'isEmailVerified': isEmailVerified,
      };

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json['id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        profilePhotoUrl: json['profilePhotoUrl'] as String?,
        isPhoneVerified: json['isPhoneVerified'] as bool? ?? true,
        isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      );
}
