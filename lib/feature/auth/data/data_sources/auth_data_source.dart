import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uas_pemmob/core/constant.dart';
import 'package:uas_pemmob/feature/auth/data/models/auth.dart';
import 'package:uas_pemmob/util/shared_preferense.dart';

part 'auth_data_source.g.dart';

@RestApi(baseUrl: Api)
abstract class AuthDataSource {
  factory AuthDataSource(Dio dio) = _AuthDataSource;

  @POST("/auth")
  Future<HttpResponse<AuthModel>> login(
    @Body() AuthModel body,
  );
}