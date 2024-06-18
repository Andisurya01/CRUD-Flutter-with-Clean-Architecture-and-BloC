import 'dart:math';

import 'package:dio/dio.dart';
import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/main_menu/data/data_sources/remote/remote_product_data_source.dart';
import 'package:uas_pemmob/main_menu/domain/entities/product.dart';
import 'package:uas_pemmob/main_menu/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RemoteProductDataSource productDataSource;

  ProductRepositoryImpl(this.productDataSource);

  @override
  Future<DataState<List<ProductEntity>>> getShoes(int? limit, int? offset) async {
    // return productDataSource.getShoes(limit, offset);
    try {
      final httpResponse = await productDataSource.getShoes(limit!, offset!);
      print(httpResponse.data);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            error: 'failed to get shoes',
          )
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<ProductEntity>> getShoesById(String id) async {
    try {
      final httpResponse = await productDataSource.getShoesById(id);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            error: 'failed to get shoes by id',
          )
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> deleteShoesById(String id) async {
    try {
      final httpResponse = await productDataSource.deleteShoesById(id);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            error: 'failed to delete shoes by id',
          )
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> addShoes(ProductEntity product) async {
    try {
      final httpResponse = await productDataSource.addShoes(product.toModel());
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            error: 'failed to add shoes',
          )
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> updateShoes(String id, ProductEntity product) async {
    try {
      final httpResponse = await productDataSource.updateShoes(id, product.toModel());
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            error: 'failed to update shoes',
          )
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}