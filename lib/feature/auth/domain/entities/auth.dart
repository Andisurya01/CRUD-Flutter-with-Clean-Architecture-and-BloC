import 'package:equatable/equatable.dart';
import 'package:uas_pemmob/feature/auth/data/models/auth.dart';
import 'package:uas_pemmob/feature/main_menu/data/models/product.dart';

class AuthEntity extends Equatable {
  final int? id;
  final String? user_name;
  final String? email;
  final String? password;
  final String? token;

  const AuthEntity({
    this.id,
    this.user_name,
    this.email,
    this.password,
    this.token,
  });

  @override
  List<Object?> get props => [id, user_name, email, password, token];

  AuthModel toModel() {
    return AuthModel(
      user_name: user_name,
      password: password,
    );
  }
}