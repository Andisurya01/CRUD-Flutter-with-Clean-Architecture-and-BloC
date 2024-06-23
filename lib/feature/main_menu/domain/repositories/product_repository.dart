import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/feature/main_menu/domain/entities/product.dart';

abstract class ProductRepository {
  Future<DataState<List<ProductEntity>>> getShoes(int limit, int offset);
  Future<DataState<ProductEntity>> getShoesById(String id);
  Future<DataState<void>> deleteShoesById(String id);
  Future<DataState<void>> addShoes(ProductEntity product);
  Future<DataState<void>> updateShoes(String id, ProductEntity product);
}