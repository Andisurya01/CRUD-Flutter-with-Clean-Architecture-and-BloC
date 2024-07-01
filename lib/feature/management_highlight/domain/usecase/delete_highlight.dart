import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/core/usecase.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/repositories/highlight_repository.dart';

class DeleteHighlightUseCase implements UseCase<DataState<void>, int>{
  final HighlightRepository _highlightRepository;

  DeleteHighlightUseCase(this._highlightRepository);

  Future<DataState<void>> call({int? params}) async {
    return _highlightRepository.deleteHighlightById(params!);
  }
}