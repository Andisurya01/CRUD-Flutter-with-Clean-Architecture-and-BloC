import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/core/usecase.dart';
import 'package:uas_pemmob/feature/main_menu/domain/entities/product.dart';
import 'package:uas_pemmob/feature/main_menu/domain/repositories/product_repository.dart';

class AddShoesUseCase implements UseCase<DataState<void>, ProductEntity> {
  final ProductRepository _shoesRepository;

  AddShoesUseCase(this._shoesRepository);

  @override
  Future<DataState<void>> call({ProductEntity? params}) {
    print('params $params');
    return _shoesRepository.addShoes(params!);
  }
}
