import 'package:uas_pemmob/feature/main_menu/domain/entities/product.dart';

abstract class RemoteProductEvent {
  const RemoteProductEvent();

  @override
  List<Object> get props => [];
}

class GetShoes extends RemoteProductEvent {
  final int limit;
  final int offset;

  GetShoes({required this.limit, required this.offset});

  @override
  List<Object> get props => [limit, offset];
}

class FilterByCategory extends RemoteProductEvent {
  final String category;

  FilterByCategory({required this.category});

  @override
  List<Object> get props => [category];
}

class GetShoesById extends RemoteProductEvent {
  final int id;

  GetShoesById({required this.id});

  @override
  List<Object> get props => [id];
}

class DeleteShoesById extends RemoteProductEvent {
  final int id;

  DeleteShoesById({required this.id});

  @override
  List<Object> get props => [id];
}

class AddShoes extends RemoteProductEvent {
  final ProductEntity shoes;

  AddShoes({required this.shoes});

  @override
  List<Object> get props => [shoes];
}

class UpdateShoes extends RemoteProductEvent {
  final int id;
  final ProductEntity shoes;

  UpdateShoes({required this.id,required this.shoes});

  @override
  List<Object> get props => [id,shoes];
}
