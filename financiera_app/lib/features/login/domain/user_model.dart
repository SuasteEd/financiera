// {user: {id: 1, name: Pruebas Pruebas, email: super@gmail.com, email_verified_at: null, two_factor_confirmed_at: null, current_team_id: null, profile_photo_path: null, created_at: 2025-05-27T17:00:17.000000Z, updated_at: 2025-05-27T17:00:17.000000Z, profile_photo_url: https://ui-avatars.com/api/?name=P+P&color=7F9CF5&background=EBF4FF}, token: 3|4J7VvlBuDsLqPQt7U6JokCQYUniZpFqK2Fs3vosQ65ca26d6}


class UserModel {
  final int id;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final String? twoFactorConfirmedAt;
  final int? currentTeamId;
  final String? profilePhotoPath;
  final String? createdAt;
  final String? updatedAt;
  final String? profilePhotoUrl;

  UserModel({
    required this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.twoFactorConfirmedAt,
    this.currentTeamId,
    this.profilePhotoPath,
    this.createdAt,
    this.updatedAt,
    this.profilePhotoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      twoFactorConfirmedAt: json['two_factor_confirmed_at'],
      currentTeamId: json['current_team_id'],
      profilePhotoPath: json['profile_photo_path'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      profilePhotoUrl: json['profile_photo_url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'two_factor_confirmed_at': twoFactorConfirmedAt,
      'current_team_id': currentTeamId,
      'profile_photo_path': profilePhotoPath,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'profile_photo_url': profilePhotoUrl,
    };
  }
}