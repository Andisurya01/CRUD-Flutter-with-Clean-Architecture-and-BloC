import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uas_pemmob/core/constant.dart';
import 'package:uas_pemmob/feature/management_highlight/data/models/highlight.dart';
import 'package:uas_pemmob/util/shared_preferense.dart';

part 'remote_highlight_data_source.g.dart';

@RestApi(baseUrl: Api)
abstract class RemoteHighlightDataSource {
  factory RemoteHighlightDataSource(Dio dio) = _RemoteHighlightDataSource;

  @GET("/highlight")
  Future<HttpResponse<List<HighlightModel>>> getHighlight(
    @Query("limit") int limit,
    @Query("offset") int offset,
  );

  @GET("/highlight/non-highlighted")
  Future<HttpResponse<List<HighlightModel>>> getNonHighlight(
    @Query("limit") int limit,
    @Query("offset") int offset,
  );

  @GET("/highlight/{id}")
  Future<HttpResponse<HighlightModel>> getHighlightById(
    @Path("id") String id,
  );

  @DELETE("/highlight/remove/{id}")
  Future<HttpResponse<void>> deleteHighlightById(
    @Path("id") String id,
  );

  @POST("/highlight/add/{id}")
  Future<HttpResponse<void>> addHighlight(
    @Path("id") String id,
  );
}