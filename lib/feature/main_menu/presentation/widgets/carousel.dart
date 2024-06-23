import 'package:flutter/material.dart';

Widget carousel() {
  return InkWell(
    onTap: () {
      print('Carousel');
    },
    child: Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
        image: const DecorationImage(
          image: AssetImage('assets/women.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(
        'Carousel',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}