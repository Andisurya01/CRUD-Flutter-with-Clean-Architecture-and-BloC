abstract class RemoteProductEvent {
  const RemoteProductEvent();

  @override
  List<Object> get props => [];
}

class GetShoes extends RemoteProductEvent{
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
  final String id;

  GetShoesById({required this.id});

  @override
  List<Object> get props => [id];
}

class DeleteShoesById extends RemoteProductEvent {
  final String id;

  DeleteShoesById({required this.id});

  @override
  List<Object> get props => [id];
}