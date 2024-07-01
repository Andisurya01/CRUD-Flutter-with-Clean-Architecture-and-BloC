import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uas_pemmob/feature/auth/presentation/bloc/remote/remote_auth_bloc.dart';
import 'package:uas_pemmob/feature/auth/presentation/bloc/remote/remote_auth_event.dart';
import 'package:uas_pemmob/feature/auth/presentation/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_pemmob/dependencies.dart';
import 'package:uas_pemmob/feature/main_menu/domain/entities/product.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/bloc/remote/remote_product_bloc.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/bloc/remote/remote_product_event.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/pages/detail_shoes.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/pages/main_menu.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_bloc.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_event.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/pages/list_product.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/pages/main_highlight.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/pages/add_product.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/pages/update_product.dart';
import 'package:uas_pemmob/splashscreen.dart';

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
            // ..add(
            //   GetShoes(limit: 10, offset: 0),
            // ),
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
        // BlocProvider<RemoteHighlightBloc>(
        //   create: (context) => GetIt.instance<RemoteHighlightBloc>()
        //     ..add(
        //       GetHighlights(limit: 100, offset: 0),
        //     ),
        // ),
        // BlocProvider<RemoteHighlightBloc>(
        //   create: (context) => GetIt.instance<RemoteHighlightBloc>()
        //     ..add(
        //       GetNonHighlights(limit: 100, offset: 0),
        //     ),
        // ),
        // BlocProvider<RemoteHighlightBloc>(
        //   create: (context) => GetIt.instance<RemoteHighlightBloc>()
        //     // ..add(
        //     //   DeleteHighlightById(id: ''),
        //     // ),
        // ),
        BlocProvider<RemoteHighlightBloc>(
            create: (context) => GetIt.instance<RemoteHighlightBloc>()
            // ..add(
            //   AddHighlight(id: ''),
            // ),
            ),
        BlocProvider<RemoteAuthBloc>(
          create: (context) => GetIt.instance<RemoteAuthBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.figtreeTextTheme(),
        ),
        // initialRoute: '/',
        home: const SplashScreen(),
        routes: {
          '/main': (context) => const MainMenu(),
          '/login': (context) => const LoginPage(),
          // '/detail_shoes': (context) {
          //   final product = ModalRoute.of(context)!.settings.arguments as ProductEntity;
          //   return DetailShoes(product: product);
          // } ,
          '/main_highlight': (context) => const MainHighlight(),
          '/list_product': (context) => const ListProduct(),
          '/edit_product': (context) {
            final product =
                ModalRoute.of(context)!.settings.arguments as ProductEntity;
            return EditProduct(product: product);
          },
          '/add_product': (context) => const AddProductScreen()
        },
      ),
    );
  }
}
