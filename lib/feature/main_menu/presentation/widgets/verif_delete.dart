import 'package:flutter/material.dart';

verifeDelete(BuildContext context, Function() onYes) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus item ini?'),
        actions: <Widget>[
          FilledButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
            ),
            child: const Text('Batal'),
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
            },
          ),
          FilledButton(
            // style: ButtonStyle(
            //   backgroundColor: C,
            // ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
            ),
            onPressed: onYes,
            child: const Text('Hapus'),
          ),
        ],
      );
    },
  );
}
