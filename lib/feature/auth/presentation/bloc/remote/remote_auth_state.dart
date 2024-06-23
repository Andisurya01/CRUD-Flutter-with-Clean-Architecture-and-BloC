import 'package:equatable/equatable.dart';
import 'package:uas_pemmob/feature/auth/domain/entities/auth.dart';

abstract class RemoteAuthState extends Equatable {
  final AuthEntity? auth;
  final Object? error;
  const RemoteAuthState({this.error, this.auth});

  @override
  List<Object> get props => [];
}

class RemoteAuthInitial extends RemoteAuthState {
  const RemoteAuthInitial();
}

class RemoteAuthLoading extends RemoteAuthState {
  const RemoteAuthLoading();
}

class RemoteAuthDone extends RemoteAuthState {
  @override
  // ignore: overridden_fields
  final AuthEntity auth;
  const RemoteAuthDone(this.auth) :super(auth: auth);
}

class RemoteAuthError extends RemoteAuthState {
  const RemoteAuthError(Object error) : super(error: error);
}