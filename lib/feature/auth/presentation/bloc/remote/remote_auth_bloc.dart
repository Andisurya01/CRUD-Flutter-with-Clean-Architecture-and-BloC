import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/feature/auth/domain/entities/auth.dart';
import 'package:uas_pemmob/feature/auth/domain/usecase/login_use_case.dart';
import 'package:uas_pemmob/feature/auth/presentation/bloc/remote/remote_auth_event.dart';
import 'package:uas_pemmob/feature/auth/presentation/bloc/remote/remote_auth_state.dart';
import 'package:uas_pemmob/util/shared_preferense.dart';

class RemoteAuthBloc extends Bloc<RemoteAuthEvent, RemoteAuthState> {
  final LoginUseCase loginUseCase;

  RemoteAuthBloc(this.loginUseCase) : super(const RemoteAuthInitial()) {
    on<Login>(onLogin);
  }

  void onLogin(Login event, Emitter<RemoteAuthState> emit) async {
    emit(const RemoteAuthLoading());

    try {
      final dataState = await loginUseCase.call(
          params:
              AuthEntity(user_name: event.user_name, password: event.password));
      print(dataState.data);
      if (dataState is DataSuccess) {
        if (dataState.data != null) {
          final token = dataState.data?.token;
          if (token != null) {
            final SharedPreferencesHelper _prefsHelper =
                SharedPreferencesHelper();
            await _prefsHelper.saveToken(token);
            emit(RemoteAuthDone(dataState.data!));
          } else {
            emit(RemoteAuthError('Token is null'));
          }
        } else {
          emit(RemoteAuthError('Data is empty'));
        }
      } else if (dataState is DataFailed) {
        print(dataState.error);
        emit(RemoteAuthError(dataState.error!.toString()));
      }
    } catch (error) {
      print(error);
      emit(RemoteAuthError('An unexpected error occurred: ${error}'));
    }
  }
}
