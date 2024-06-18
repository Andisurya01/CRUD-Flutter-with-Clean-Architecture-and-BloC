import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uas_pemmob/auth/presentation/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_pemmob/dependencies.dart';
import 'package:uas_pemmob/main_menu/domain/entities/product.dart';
import 'package:uas_pemmob/main_menu/presentation/bloc/remote/remote_product_bloc.dart';
import 'package:uas_pemmob/main_menu/presentation/bloc/remote/remote_product_event.dart';
import 'package:uas_pemmob/main_menu/presentation/pages/detail_shoes.dart';
import 'package:uas_pemmob/main_menu/presentation/pages/main_menu.dart';
import 'package:uas_pemmob/management_highlight/presentation/pages/list_product.dart';
import 'package:uas_pemmob/management_highlight/presentation/pages/main_highlight.dart';
import 'package:uas_pemmob/management_shoes/presentation/pages/add_product.dart';
import 'package:uas_pemmob/management_shoes/presentation/pages/edit_product.dart';

void main() {
  setupDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteProductBloc>(
          create: (context) => GetIt.instance<RemoteProductBloc>()
            ..add(
              GetShoes(limit: 10, offset: 0),
            ),
        ),
        // BlocProvider<RemoteProductBloc>(
        //   create: (context) => GetIt.instance<RemoteProductBloc>()
        //     ..add(
        //       GetShoesById(),
        //     ),
        //   )
        // BlocProvider<RemoteProductBloc>(
        //   create: (context) => GetIt.instance<RemoteProductBloc>()
        //   .add(DeleteShoesById(id: id)));
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.figtreeTextTheme(),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MainMenu(),
          '/login': (context) => const LoginPage(),
          // '/detail_shoes': (context) {
          //   final product = ModalRoute.of(context)!.settings.arguments as ProductEntity;
          //   return DetailShoes(product: product);
          // } ,
          '/main_highlight': (context) => const MainHiglight(),
          '/list_product': (context) => const ListProduct(),
          '/edit_product': (context) => const EditProduct(),
          '/add_product': (context) => const AddProduct()
        },
      ),
    );
  }
}
