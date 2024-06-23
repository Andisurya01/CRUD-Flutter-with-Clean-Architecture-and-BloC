import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/bloc/remote/remote_product_bloc.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/bloc/remote/remote_product_event.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/bloc/remote/remote_product_state.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/pages/detail_shoes.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/widgets/card.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/widgets/carousel.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/widgets/profile.dart';
import 'package:uas_pemmob/util/shared_preferense.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();

  _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    print('token di menu : ${prefs.getString('auth_token')}');
  }

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<RemoteProductBloc>(context).add(FilterByCategory(
          category: "Category1")); // Sesuaikan dengan email yang tepat
    });
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', height: 30),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomPopup(
                      title: 'Welcome!',
                      message: 'This is a custom popup.',
                    );
                  },
                );
              },
              icon: const Icon(Icons.person),
            ),
          )
        ],
      ),
      body: BlocBuilder<RemoteProductBloc, RemoteProductState>(
        builder: (context, state) {
          if (state is RemoteProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RemoteProductDone) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    carousel(),
                    const SizedBox(height: 16),
                    const Text(
                      "Category",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<RemoteProductBloc>(context)
                                .add(FilterByCategory(category: "Category1"));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Woman",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<RemoteProductBloc>(context)
                                .add(FilterByCategory(category: "Category2"));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text("Man"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<RemoteProductBloc>(context)
                                .add(FilterByCategory(category: "Category3"));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text("Kids"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(state.products.length, (index) {
                        final product = state.products[index];
                        final image = product.image;
                        final name = product.name;
                        final price = product.price;
                        return card(name, price, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailShoes(product: product)));
                          // Navigator.pushNamed(context, '/detail_shoes',
                          //     product: product);
                        });
                      }),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is RemoteProductError) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: FloatingActionButton(
                heroTag: 'manage_highlight',
                backgroundColor: Colors.grey[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/main_highlight');
                },
                child: const Text(
                  "Manage Highlight",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              heroTag: 'add_shoes',
              backgroundColor: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/add_product');
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
