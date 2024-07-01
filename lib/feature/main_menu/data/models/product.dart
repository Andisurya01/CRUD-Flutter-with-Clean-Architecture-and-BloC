import 'dart:io';

import 'package:uas_pemmob/feature/main_menu/domain/entities/product.dart';

class ProductModels extends ProductEntity{
  final File? imageFile;

  const ProductModels({
    required super.id,
    super.name,
    super.description,
    super.price,
    super.stock,
    super.image,
    super.size,
    super.rating,
    super.category,
    this.imageFile
  });

  factory ProductModels.fromJson(Map<String, dynamic> json){
    return ProductModels(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      stock: json['stock'] ?? '',
      image: json['image'] ?? '',
      size: json['size'] ?? '',
      rating: json['rating'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'image': image,
      'size': size,
      'rating': rating,
      'category': category,
    };
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'image': image,
      'size': size,
      'rating': rating,
      'category': category,
    };
  }
}