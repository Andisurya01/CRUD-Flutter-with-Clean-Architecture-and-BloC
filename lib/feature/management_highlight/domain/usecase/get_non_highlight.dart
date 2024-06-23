import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/core/usecase.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/entities/highlight.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/repositories/highlight_repository.dart';

class GetNonHighlightUseCase implements UseCase<DataState<List<HighlightEntity>>, ParamsNonHighlight>{
  final HighlightRepository repository;

  GetNonHighlightUseCase(this.repository);

  @override
  Future<DataState<List<HighlightEntity>>> call({ParamsNonHighlight? params}) {
    return repository.getNonHighlight(params!.limit, params.offset);
  }
}
class ParamsNonHighlight {
  final int limit;
  final int offset;

  ParamsNonHighlight({required this.limit, required this.offset});
}