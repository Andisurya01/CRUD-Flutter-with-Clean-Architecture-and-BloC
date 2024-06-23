import 'package:flutter/material.dart';

Widget card(
  String name,
  int price,

  Function()? onTap,
) {
  return InkWell(
    onTap: onTap,
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
              image: const DecorationImage(
                image: AssetImage('assets/kids.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Rp $price",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
  
  );
}
