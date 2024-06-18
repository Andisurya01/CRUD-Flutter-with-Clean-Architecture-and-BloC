import 'package:equatable/equatable.dart';
import 'package:uas_pemmob/main_menu/domain/entities/product.dart';

abstract class RemoteProductState extends Equatable{
  final List<ProductEntity>? products;
  final Object? error;
  const RemoteProductState({this.products, this.error});

  @override
  List<Object?> get props => [products, error];
}

class RemoteProductInitial extends RemoteProductState {
  RemoteProductInitial() : super(products: []);
}

class RemoteProductLoading extends RemoteProductState {
  const RemoteProductLoading();
}

class RemoteProductDone extends RemoteProductState {
  @override
  // ignore: overridden_fields
  final List<ProductEntity> products;
  const RemoteProductDone(this.products) : super(products: products);
}

class RemoteProductError extends RemoteProductState{
  const RemoteProductError(Object error) : super(error: error);
}