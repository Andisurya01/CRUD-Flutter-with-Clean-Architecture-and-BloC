import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/core/usecase.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/entities/highlight.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/repositories/highlight_repository.dart';

class GetAllHighlightUseCase implements UseCase<DataState<List<HighlightEntity>>, Params>{
  final HighlightRepository _highlightRepository;

  GetAllHighlightUseCase(this._highlightRepository);

  @override
  Future<DataState<List<HighlightEntity>>> call({Params? params}) {
    return _highlightRepository.getHighlight(params!.limit, params.offset);
  }
}

class Params {
  final int limit;
  final int offset;

  Params({required this.limit, required this.offset});
}