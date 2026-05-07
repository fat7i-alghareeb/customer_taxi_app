class UserEntity {
  const UserEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profilePhotoUrl,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? profilePhotoUrl;

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profilePhotoUrl,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'profilePhotoUrl': profilePhotoUrl,
      };

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json['id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        profilePhotoUrl: json['profilePhotoUrl'] as String?,
      );
}
