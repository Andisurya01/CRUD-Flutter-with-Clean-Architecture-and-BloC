import 'package:flutter/material.dart';
import 'package:uas_pemmob/main_menu/presentation/pages/main_menu.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _description = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Padding( 
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Description',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
              style: const TextStyle(fontSize: 12),
              onSaved: (value) {
                _description = value!;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Description',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
              style: const TextStyle(fontSize: 12),
              onSaved: (value) {
                _description = value!;
              },
            ),
            FilledButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu()));
            }, child: Text('Login'))
          ],
        ),
      ),
    ));
  }
}
