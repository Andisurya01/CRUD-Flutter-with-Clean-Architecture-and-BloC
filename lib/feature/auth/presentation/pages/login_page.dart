import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_pemmob/feature/auth/presentation/bloc/remote/remote_auth_bloc.dart';
import 'package:uas_pemmob/feature/auth/presentation/bloc/remote/remote_auth_event.dart';
import 'package:uas_pemmob/util/shared_preferense.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? user_name = '';
  String? password = '';
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();

  Future<void> _checkIfLoggedIn() async {
    String? token = await _prefsHelper.getToken();
    if (token != null) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  void _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('username: $user_name, password: $password');
      BlocProvider.of<RemoteAuthBloc>(context)
          .add(Login(user_name: user_name!, password: password!));
      
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // BlocListener<RemoteAuthBloc, RemoteAuthState>(
          //   listener: (context, state) {
          //     if (state is RemoteAuthDone) {
          //       _prefsHelper.saveToken(state.auth.token!);
          //       Navigator.pushReplacementNamed(context, '/main');
          //     } else if (state is RemoteAuthError) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(content: Text(state.error.toString())),
          //       );
          //     }
          //   },
          //   child:
          Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  user_name = value!;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onLoginButtonPressed,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
