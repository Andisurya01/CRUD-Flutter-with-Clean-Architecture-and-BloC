import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:uas_pemmob/feature/auth/data/data_sources/auth_data_source.dart';
import 'package:uas_pemmob/feature/auth/data/repository/auth_repository.dart';
import 'package:uas_pemmob/feature/auth/domain/repositories/auth_repositories.dart';
import 'package:uas_pemmob/feature/auth/domain/usecase/login_use_case.dart';
import 'package:uas_pemmob/feature/auth/presentation/bloc/remote/remote_auth_bloc.dart';
import 'package:uas_pemmob/feature/main_menu/data/data_sources/remote/remote_product_data_source.dart';
import 'package:uas_pemmob/feature/main_menu/data/repository/product_repository_impl.dart';
import 'package:uas_pemmob/feature/main_menu/domain/repositories/product_repository.dart';
import 'package:uas_pemmob/feature/main_menu/domain/usecase/delete_shoes_use_case.dart';
import 'package:uas_pemmob/feature/main_menu/domain/usecase/get_shoes_use_case.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/bloc/remote/remote_product_bloc.dart';
import 'package:uas_pemmob/feature/management_highlight/data/data_sources/remote/remote_highlight_data_source.dart';
import 'package:uas_pemmob/feature/management_highlight/data/repository/highlight_repository_impl.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/repositories/highlight_repository.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/usecase/add_highlight.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/usecase/delete_highlight.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/usecase/get_all_highlight.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/usecase/get_non_highlight.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_bloc.dart';


Future<void> setupDependencies() async{
  final getIt = GetIt.instance;
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerSingleton<RemoteProductDataSource>(RemoteProductDataSource(getIt()));
  getIt.registerSingleton<RemoteHighlightDataSource>(RemoteHighlightDataSource(getIt()));
  getIt.registerSingleton<AuthDataSource>(AuthDataSource(getIt()));

  // Repository
  getIt.registerSingleton<ProductRepository>(ProductRepositoryImpl(getIt()));
  getIt.registerSingleton<HighlightRepository>(HighlightRepositoryImpl(getIt()));
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(getIt()));

  // Use Case
  getIt.registerSingleton<GetShoesUseCase>(GetShoesUseCase(getIt()));
  getIt.registerSingleton<DeleteShoesUseCase>(DeleteShoesUseCase(getIt()));

  // Use Case - Auth
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt()));

  // Use Case - Highlight
  getIt.registerSingleton<GetAllHighlightUseCase>(GetAllHighlightUseCase(getIt()));
  getIt.registerSingleton<AddHighlightUseCase>(AddHighlightUseCase(getIt()));
  getIt.registerSingleton<DeleteHighlightUseCase>(DeleteHighlightUseCase(getIt()));
  getIt.registerSingleton<GetNonHighlightUseCase>(GetNonHighlightUseCase(getIt()));

  // Bloc
  getIt.registerFactory<RemoteProductBloc>(() => RemoteProductBloc(getIt(), getIt()));
  getIt.registerFactory<RemoteHighlightBloc>(() => RemoteHighlightBloc(getIt(), getIt(), getIt(),getIt()));
  getIt.registerFactory<RemoteAuthBloc>(() => RemoteAuthBloc(getIt()));
}