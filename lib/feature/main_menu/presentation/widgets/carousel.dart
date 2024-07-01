import 'package:flutter/material.dart';

Widget carousel() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(4, (index) {
        return InkWell(
          onTap: () {
            print('Carousel Item $index');
          },
          child: Container(
            height: 200,
            width: 500,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              image: const DecorationImage(
                image: AssetImage('assets/women.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Text(
                'Carousel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }),
    ),
  );
}
