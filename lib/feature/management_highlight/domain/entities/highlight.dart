import 'package:equatable/equatable.dart';

class HighlightEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final int price;
  final int stock;
  final String image;
  final int size;
  final int rating;
  final String category;

  const HighlightEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.size,
    required this.rating,
    required this.category,
  });

  @override
  List<Object?> get props =>
      [id, name, description, price, stock, image, size, rating, category];
  
  HighlightEntity toModel() {
    return HighlightEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      stock: stock,
      image: image,
      size: size,
      rating: rating,
      category: category,
    );
  }
}