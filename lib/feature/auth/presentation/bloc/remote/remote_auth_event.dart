abstract class RemoteAuthEvent {
  const RemoteAuthEvent();

  @override
  List<Object> get props => [];
}

class Login extends RemoteAuthEvent {
  final String user_name;
  final String password;

  Login({required this.user_name, required this.password});

  @override
  List<Object> get props => [user_name, password];
}