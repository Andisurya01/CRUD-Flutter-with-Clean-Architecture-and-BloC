import 'package:flutter/material.dart';
import 'package:uas_pemmob/util/shared_preferense.dart';

class CustomPopup extends StatelessWidget {
  final String title;
  final String message;

  CustomPopup({
    required this.title,
    required this.message,
  });
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();

  Future<void> _logout(BuildContext context) async {
    await _prefsHelper.removeToken();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      backgroundColor: Colors.white,
      titleTextStyle: const TextStyle(color: Colors.black, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FilledButton(
          // style: ButtonStyle(
          //   backgroundColor: C,
          // ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
          ),
          onPressed: () => _logout(context),
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
