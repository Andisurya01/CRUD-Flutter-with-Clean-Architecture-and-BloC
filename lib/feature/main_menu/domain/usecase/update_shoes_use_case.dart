import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/core/usecase.dart';
import 'package:uas_pemmob/feature/main_menu/domain/entities/product.dart';
import 'package:uas_pemmob/feature/main_menu/domain/repositories/product_repository.dart';

class UpdateShoeUseCase implements UseCase<DataState<void>, UpdateShoeParams> {
  final ProductRepository productRepository;

  UpdateShoeUseCase(this.productRepository);

  @override
  Future<DataState<void>> call({UpdateShoeParams? params}) {
    return productRepository.updateShoes(params!.id, params.product);
  }
}

class UpdateShoeParams {
  final int id;
  final ProductEntity product;

  UpdateShoeParams({required this.id, required this.product});
}
