import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/feature/main_menu/domain/usecase/add_shoes_use_case.dart';
import 'package:uas_pemmob/feature/main_menu/domain/usecase/delete_shoes_use_case.dart';
import 'package:uas_pemmob/feature/main_menu/domain/usecase/get_shoes_use_case.dart';
import 'package:uas_pemmob/feature/main_menu/domain/usecase/get_shoes_by_id_use_case.dart';
import 'package:uas_pemmob/feature/main_menu/domain/usecase/update_shoes_use_case.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/bloc/remote/remote_product_event.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/bloc/remote/remote_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteProductBloc extends Bloc<RemoteProductEvent, RemoteProductState> {
  final GetShoesUseCase getShoesUseCase;
  // final GetShoesByIdUseCase getShoesByIdUseCase;
  final DeleteShoesUseCase deleteShoesUseCase;
  final AddShoesUseCase addShoesUseCase;
  final UpdateShoeUseCase updateShoeUseCase;

  RemoteProductBloc(this.getShoesUseCase, this.deleteShoesUseCase,
      this.addShoesUseCase, this.updateShoeUseCase)
      : super(const RemoteProductLoading()) {
    on<GetShoes>(onGetShoesList);
    on<FilterByCategory>(onFilterByCategory);
    on<DeleteShoesById>(onDeleteShoesById);
    on<AddShoes>(onAddShoes);
    on<UpdateShoes>(onUpdateShoes);
  }

  void onGetShoesList(GetShoes event, Emitter<RemoteProductState> emit) async {
    emit(const RemoteProductLoading());
    final dataState = await getShoesUseCase.call(
        params: Params(limit: event.limit, offset: event.offset));
    if (dataState is DataSuccess) {
      if (dataState.data != null && dataState.data!.isNotEmpty) {
        emit(RemoteProductDone(dataState.data!));
      } else {
        emit(const RemoteProductError('Data is empty'));
      }
    } else if (dataState is DataFailed) {
      emit(RemoteProductError(dataState.error!));
    }
  }

  void onFilterByCategory(
      FilterByCategory event, Emitter<RemoteProductState> emit) async {
    // Simulasikan panggilan API untuk kategori yang difilter
    final dataState = await getShoesUseCase.call(
        params: Params(
            limit: 100,
            offset: 0)); // Tambahkan parameter untuk filter kategori jika perlu
    if (dataState is DataSuccess) {
      final filteredProducts = dataState.data!
          .where((product) => product.category == event.category)
          .toList();
      if (filteredProducts.isNotEmpty) {
        emit(RemoteProductDone(filteredProducts));
      } else {
        emit(const RemoteProductError('No products found in this category'));
      }
    } else if (dataState is DataFailed) {
      emit(RemoteProductError(dataState.error!));
    }
  }

  // void onGetShoesById(GetShoesById event, Emitter<RemoteProductState> emit) async {
  //   emit(const RemoteProductLoading());
  //   final dataState = await getShoesByIdUseCase.call(params: event.id);
  //   if (dataState is DataSuccess) {
  //     if (dataState.data != null) {
  //       emit(RemoteProductDone([dataState.data!]));
  //     } else {
  //       emit(const RemoteProductError('Data is empty'));
  //     }
  //   } else if (dataState is DataFailed) {
  //     emit(RemoteProductError(dataState.error!));
  //   }
  // }

  void onDeleteShoesById(
      DeleteShoesById event, Emitter<RemoteProductState> emit) async {
    emit(const RemoteProductLoading());
    final dataState = await deleteShoesUseCase.call(params: event.id);
    if (dataState is DataSuccess) {
      emit(const RemoteProductDone([]));
    } else if (dataState is DataFailed) {
      emit(RemoteProductError(dataState.error!));
    }
  }

  void onAddShoes(AddShoes event, Emitter<RemoteProductState> emit) async {
    emit(const RemoteProductLoading());
    print(event.shoes.imageFile!.path);
    final dataState = await addShoesUseCase.call(params: event.shoes);
    if (dataState is DataSuccess) {
      emit(const RemoteProductDone([]));
    } else if (dataState is DataFailed) {
      emit(RemoteProductError(dataState.error!));
    }
  }

  void onUpdateShoes(
      UpdateShoes event, Emitter<RemoteProductState> emit) async {
    emit(const RemoteProductLoading());
    final dataState = await updateShoeUseCase.call(
        params: UpdateShoeParams(id: event.id, product: event.shoes));
    if (dataState is DataSuccess) {
      print('Success');
      emit(const RemoteProductDone([]));
    } else if (dataState is DataFailed) {
      print(dataState.error!);
      emit(RemoteProductError(dataState.error!));
    }
  }
}
