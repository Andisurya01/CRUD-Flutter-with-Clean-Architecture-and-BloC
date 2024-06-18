import 'package:flutter/material.dart';

Widget card(
  Function()? onTap,
) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              image: const DecorationImage(
                image: AssetImage('assets/kids.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Product Name",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Rp 100.000",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  );
}
