import 'package:dio/dio.dart';
import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/feature/auth/data/data_sources/auth_data_source.dart';
import 'package:uas_pemmob/feature/auth/domain/entities/auth.dart';
import 'package:uas_pemmob/feature/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<DataState<AuthEntity>> login(AuthEntity auth) async {
    final response = await authDataSource.login(auth.toModel());
    print(response.data);
    if (response.response.statusCode == 200) {
      print(response.data);
      return DataSuccess(response.data);
    } else {
      print('auth repo  ${response.response}');
      return DataFailed(DioException(
        requestOptions: response.response.requestOptions,
        response: response.response,
        error: 'failed to login',
      ));
    }
  }
}
