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
      alignment: Alignment.center,
      backgroundColor: Colors.white,
      titleTextStyle: const TextStyle(color: Colors.black, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Logout',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () {
            _logout(context);// Tutup popup saat tombol OK ditekan
          },
        ),
      ],
    );
  }
}
