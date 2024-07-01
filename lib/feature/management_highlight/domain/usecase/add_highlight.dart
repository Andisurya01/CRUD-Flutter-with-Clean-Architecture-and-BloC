import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/core/usecase.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/repositories/highlight_repository.dart';

class AddHighlightUseCase implements UseCase<DataState<void>, int>{
  final HighlightRepository _highlightRepository;

  AddHighlightUseCase(this._highlightRepository);

  @override
  Future<DataState<void>> call({int? params}) {
    return _highlightRepository.addHighlight(params!);
  }
}