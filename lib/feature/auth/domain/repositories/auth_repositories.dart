import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/feature/auth/domain/entities/auth.dart';

abstract class AuthRepository {
  Future<DataState<AuthEntity>> login(AuthEntity auth);
}