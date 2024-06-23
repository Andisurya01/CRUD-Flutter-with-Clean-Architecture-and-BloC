import 'package:uas_pemmob/feature/auth/domain/entities/auth.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    super.id,
    super.user_name,
    super.email,
    super.password,
    super.token
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': user_name,
      'password': password,
    };
  }
}