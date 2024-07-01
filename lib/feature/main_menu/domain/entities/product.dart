import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:uas_pemmob/feature/main_menu/data/models/product.dart';

class ProductEntity extends Equatable {
  final int id;
  final String? name;
  final String? description;
  final int? price;
  final int? stock;
  final String? image;
  final int? size;
  final int? rating;
  final String? category;
  final File? imageFile;

  const ProductEntity(
      {required this.id,
      this.name,
      this.description,
      this.price,
      this.stock,
      this.image,
      this.size,
      this.rating,
      this.category,
      this.imageFile});

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        stock,
        image,
        size,
        rating,
        category,
        imageFile
      ];

  ProductModels toModel() {
    return ProductModels(
        id: id,
        name: name,
        description: description,
        price: price,
        stock: stock,
        image: image,
        size: size,
        rating: rating,
        category: category,
        imageFile: imageFile);
  }
}
