import 'package:flutter/material.dart';
import 'package:uas_pemmob/util/shared_preferense.dart';

class CustomPopupWidget extends StatelessWidget {
  
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();

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
      title: Text('Gagal Login'),
      // content: Text(''),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Logout',
            style: TextStyle(
              color: Colors.grey[900],
            ),
          ),
          onPressed: () {
            Navigator.pop(context); // Tutup popup saat tombol OK ditekan
          },
        ),
      ],
    );
  }
}
