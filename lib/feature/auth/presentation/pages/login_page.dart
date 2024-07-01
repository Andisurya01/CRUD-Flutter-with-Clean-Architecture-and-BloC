import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_pemmob/feature/auth/presentation/bloc/remote/remote_auth_bloc.dart';
import 'package:uas_pemmob/feature/auth/presentation/bloc/remote/remote_auth_event.dart';
import 'package:uas_pemmob/feature/auth/presentation/bloc/remote/remote_auth_state.dart';
import 'package:uas_pemmob/feature/auth/presentation/widget/custom_widget_popup.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/widgets/profile.dart';
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
  bool _isLoading = false;

  Future<void> _checkIfLoggedIn() async {
    try {
      String? token = await _prefsHelper.getToken();
      if (token != null) {
        Navigator.pushReplacementNamed(context, '/main');
      }
    } catch (error) {
      print('Error checking if logged in: $error');
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RemoteAuthBloc, RemoteAuthState>(
        listener: (context, state) {
          if (state is RemoteAuthDone) {
            _prefsHelper.saveToken(state.auth.token!);
            Navigator.pushReplacementNamed(context, '/main');
          } else if (state is RemoteAuthError) {
            print('Error: ${state.message}');
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  // content: const Text(
                  //   'Login Failed',
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  actions: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text(
                            'Logi gagal, coba periksa email dan password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        FilledButton(
                          // style: ButtonStyle(
                          //   backgroundColor: C,
                          // ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey[900]),
                          ),
                          onPressed: () {
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Ok'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ).then((_) {
              setState(() {
                _isLoading = false;
              });
            });
          } else if (state is RemoteAuthLoading) {
            setState(() {
              _isLoading = true;
            });
          } else {
            setState(() {
              _isLoading = false;
            });
          }
        },
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Image.asset('assets/logo_olg.jpg', height: 100)),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text('Username :'),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your username',
                        border: OutlineInputBorder(),
                      ),
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
                    const SizedBox(height: 20),
                    const Text('Password :'),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(),
                      ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(130, 30),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _isLoading ? null : _onLoginButtonPressed,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Login'),
                              Icon(Icons.arrow_forward_sharp)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading)
              ModalBarrier(
                color: Colors.black.withOpacity(0.5),
                dismissible: false,
              ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
