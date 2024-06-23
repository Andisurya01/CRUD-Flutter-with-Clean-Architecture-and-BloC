import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/core/usecase.dart';
import 'package:uas_pemmob/feature/auth/domain/entities/auth.dart';
import 'package:uas_pemmob/feature/auth/domain/repositories/auth_repositories.dart';

class LoginUseCase implements UseCase<DataState<AuthEntity>, AuthEntity> {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  @override
  Future<DataState<AuthEntity>> call({AuthEntity? params}) {
    return authRepository.login(params!);
  }
}