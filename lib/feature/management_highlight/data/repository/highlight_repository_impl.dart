import 'package:dio/dio.dart';
import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/feature/management_highlight/data/data_sources/remote/remote_highlight_data_source.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/entities/highlight.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/repositories/highlight_repository.dart';

class HighlightRepositoryImpl implements HighlightRepository {
  final RemoteHighlightDataSource dataSource;

  HighlightRepositoryImpl(this.dataSource);
  @override
  Future<DataState<List<HighlightEntity>>> getHighlight(
      int? limit, int? offset) async {
    try {
      final httpResponse = await dataSource.getHighlight(limit!, offset!);
      print('respon data repository${httpResponse.data}');
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          response: httpResponse.response,
          error: 'failed to get highlight',
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<HighlightEntity>>> getNonHighlight(
      int? limit, int? offset) async {
    try {
      final httpResponse = await dataSource.getNonHighlight(limit!, offset!);
      print('respon data repository${httpResponse.data}');
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          response: httpResponse.response,
          error: 'failed to get highlight',
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> addHighlight(int id) async {
    try {
      final httpResponse = await dataSource.addHighlight(id);
      if (httpResponse.response.statusCode == 201) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          response: httpResponse.response,
          error: 'failed to add highlight',
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> deleteHighlightById(int id) async {
    try {
      final httpResponse = await dataSource.deleteHighlightById(id);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          response: httpResponse.response,
          error: 'failed to delete highlight',
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<HighlightEntity>> getHighlightById(int id) async {
    try {
      final httpResponse = await dataSource.getHighlightById(id);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          response: httpResponse.response,
          error: 'failed to get highlight by id',
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
