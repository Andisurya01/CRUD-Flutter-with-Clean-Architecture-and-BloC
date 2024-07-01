import 'package:uas_pemmob/feature/management_highlight/domain/entities/highlight.dart';

class HighlightModel extends HighlightEntity{
  const HighlightModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.stock,
    required super.image,
    required super.size,
    required super.rating,
    required super.category,
  });
  factory HighlightModel.fromJson(Map<String, dynamic> json){
    return HighlightModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      image: json['image'],
      size: json['size'],
      rating: json['rating'],
      category: json['category'],
    );
  }
  Map<String, dynamic> toJson(){
    return {
      // 'id': id,
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