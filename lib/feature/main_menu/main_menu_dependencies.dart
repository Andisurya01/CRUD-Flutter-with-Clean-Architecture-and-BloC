// import 'package:uas_pemmob/main_menu/data/data_sources/remote/remote_product_data_source.dart';
// import 'package:uas_pemmob/main_menu/data/repository/product_repository_impl.dart';
// import 'package:uas_pemmob/main_menu/domain/repositories/product_repository.dart';
// import 'package:uas_pemmob/main_menu/domain/usecase/get_shoes_use_case.dart';
// import 'package:uas_pemmob/main_menu/presentation/bloc/remote/remote_product_bloc.dart';

// import '../dependencies.dart';

// void setupMainMenuDependencies() {
//   // Data Resource
//   getIt.registerSingleton<RemoteProductDataSource>(RemoteProductDataSource(getIt()));

//   // Repository
//   getIt.registerSingleton<ProductRepository>(ProductRepositoryImpl(getIt()));

//   // Use Case
//   getIt.registerSingleton<GetShoesUseCase>(GetShoesUseCase(getIt()));

//   // Bloc
//   getIt.registerFactory<RemoteProductBloc>(() => RemoteProductBloc(getIt()));
// }