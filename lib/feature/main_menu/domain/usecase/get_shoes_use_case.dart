import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/core/usecase.dart';
import 'package:uas_pemmob/feature/main_menu/domain/entities/product.dart';
import 'package:uas_pemmob/feature/main_menu/domain/repositories/product_repository.dart';

class GetShoesUseCase implements UseCase<DataState<List<ProductEntity>>, Params> {
  final ProductRepository productRepository;

  GetShoesUseCase(this.productRepository);

  @override
  Future<DataState<List<ProductEntity>>> call({ Params? params}) {
    return productRepository.getShoes(params?.limit ??10, params?.offset ?? 0);
  }
}

class Params {
  final int limit;
  final int offset;

  Params( {required this.limit, required this.offset});
}
