import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/core/usecase.dart';
import 'package:uas_pemmob/feature/main_menu/domain/repositories/product_repository.dart';

class DeleteShoesUseCase implements UseCase<DataState<void>, int> {
  final ProductRepository productRepository;

  DeleteShoesUseCase(this.productRepository);

  @override
  Future<DataState<void>> call({int? params}) { 
    return productRepository.deleteShoesById(params!);
  }
}