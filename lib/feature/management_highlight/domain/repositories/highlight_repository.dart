import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/entities/highlight.dart';

abstract class HighlightRepository {
  Future<DataState<List<HighlightEntity>>> getHighlight(int limit, int offset);
  Future<DataState<List<HighlightEntity>>> getNonHighlight(int limit, int offset);
  Future<DataState<HighlightEntity>> getHighlightById(String id);
  Future<DataState<void>> deleteHighlightById(String id);
  Future<DataState<void>> addHighlight(String id);
}