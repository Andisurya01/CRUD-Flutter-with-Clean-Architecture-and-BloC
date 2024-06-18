import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/core/usecase.dart';
import 'package:uas_pemmob/main_menu/domain/entities/product.dart';
import 'package:uas_pemmob/main_menu/domain/repositories/product_repository.dart';

class GetShoesByIdUseCase implements UseCase<DataState<ProductEntity>, String> {
  final ProductRepository productRepository;

  GetShoesByIdUseCase(this.productRepository);

  @override
  Future<DataState<ProductEntity>> call({String? params}) {
    return productRepository.getShoesById(params!);
  }
}