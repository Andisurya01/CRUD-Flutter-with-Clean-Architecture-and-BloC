import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas_pemmob/core/constant.dart';

Widget card(
  String image,
  String name,
  int price,
  Function()? onTap,
) {
  final formattedPrice = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(price);
  return InkWell(
    onTap: onTap,
    child: Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 230,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
              image: DecorationImage(
                image: NetworkImage('$Api/uploads/$image'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            formattedPrice,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  );
}
