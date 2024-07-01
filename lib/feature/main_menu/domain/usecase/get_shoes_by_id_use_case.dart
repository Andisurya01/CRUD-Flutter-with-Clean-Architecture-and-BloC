import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/core/usecase.dart';
import 'package:uas_pemmob/feature/main_menu/domain/entities/product.dart';
import 'package:uas_pemmob/feature/main_menu/domain/repositories/product_repository.dart';

class GetShoesByIdUseCase implements UseCase<DataState<ProductEntity>, int> {
  final ProductRepository productRepository;

  GetShoesByIdUseCase(this.productRepository);

  @override
  Future<DataState<ProductEntity>> call({int? params}) {
    return productRepository.getShoesById(params!);
  }
}