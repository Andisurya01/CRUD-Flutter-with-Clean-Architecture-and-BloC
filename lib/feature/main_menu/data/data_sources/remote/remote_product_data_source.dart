import 'package:retrofit/retrofit.dart';
import 'package:uas_pemmob/core/constant.dart';
import 'package:dio/dio.dart';
import 'package:uas_pemmob/feature/main_menu/data/models/product.dart';
import 'package:uas_pemmob/feature/main_menu/domain/entities/product.dart';
import 'package:uas_pemmob/util/shared_preferense.dart';

part 'remote_product_data_source.g.dart';

@RestApi(baseUrl: Api)
abstract class RemoteProductDataSource {
  factory RemoteProductDataSource(Dio dio) = _RemoteProductDataSource;

  @GET("/shoes")
  Future<HttpResponse<List<ProductModels>>> getShoes(
    @Query("limit") int limit,
    @Query("offset") int offset,
  );

  @GET("/shoes/{id}")
  Future<HttpResponse<ProductModels>> getShoesById(
    @Path("id") int id,
  );

  @DELETE("/shoes/{id}")
  Future<HttpResponse<void>> deleteShoesById(
    @Path("id") int id,
  );

  @POST("/shoes")
  Future<HttpResponse<void>> addShoes(
    @Body() ProductModels product,
  );

  @PUT("/shoes/{id}")
  Future<HttpResponse<void>> updateShoes(
    @Path("id") int id,
    @Body() ProductModels product,
  );
}