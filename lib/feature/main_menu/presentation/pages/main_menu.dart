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
  String category = 'women';
  _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    print('token di menu : ${prefs.getString('auth_token')}');
  }

  @override
  void initState() {
    super.initState();
    _getToken();
    BlocProvider.of<RemoteProductBloc>(context).add(FilterByCategory(
        category: "women")); // Sesuaikan dengan email yang tepat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', height: 30),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomPopup(
                    title: 'Logout?',
                    message: 'Apaka kamu yakin ingin logout?',
                  );
                },
              );
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: BlocBuilder<RemoteProductBloc, RemoteProductState>(
        builder: (context, state) {
          if (state is RemoteProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RemoteProductDone) {
            return SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<RemoteProductBloc>(context)
                      .add(FilterByCategory(category: "women"));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      carousel(),
                      const SizedBox(height: 16),
                      const Text(
                        "Category",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<RemoteProductBloc>(context)
                                  .add(FilterByCategory(category: "women"));
                              setState(() {
                                category = 'women';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: category == 'women'
                                    ? Colors.grey[900]
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "women",
                                style: TextStyle(
                                  color: category == 'women'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<RemoteProductBloc>(context)
                                  .add(FilterByCategory(category: "men"));
                              setState(() {
                                category = 'men';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: category == 'men'
                                    ? Colors.grey[900]
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "men",
                                style: TextStyle(
                                  color: category == 'men'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<RemoteProductBloc>(context)
                                  .add(FilterByCategory(category: "kids"));
                              setState(() {
                                category = 'kids';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: category == 'kids'
                                    ? Colors.grey[900]
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "kidss",
                                style: TextStyle(
                                  color: category == 'kids'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      LayoutBuilder(builder: (context, constraints) {
                        int crossAxisCount = constraints.maxWidth < 600 ? 1 : 2;
                        return GridView.count(
                          crossAxisCount: crossAxisCount, // Number of columns
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children:
                              List.generate(state.products.length, (index) {
                            final product = state.products[index];
                            final image =
                                product.image ?? 'assets/no_image.png';
                            final name = product.name ?? 'No Name';
                            final price = product.price ?? 000;
                            return card(image, name, price, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailShoes(product: product)));
                              // Navigator.pushNamed(context, '/detail_shoes',
                              //     product: product);
                            });
                          }),
                          // Each tile will take up 2 columns and adjust its height to fit its content
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is RemoteProductError) {
            return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<RemoteProductBloc>(context)
                      .add(GetShoes(limit: 100, offset: 0));
                },
                child: Center(child: Text('Error: ${state.error}')));
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
