import 'package:flutter/material.dart';
import 'package:uas_pemmob/main_menu/presentation/pages/detail_shoes.dart';
import 'package:uas_pemmob/main_menu/presentation/widgets/card.dart';
import 'package:uas_pemmob/main_menu/presentation/widgets/carousel.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', height: 30),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.person),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              carousel(),
              SizedBox(height: 16),
              Text("Category",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Woman"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Man"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Kids"),
                  ),
                ],
              ),
              SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(10, (index) {
                  return card(() {
                    Navigator.pushNamed(context, '/detail_shoes');
                  });
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: FloatingActionButton(
                heroTag: 'manage_highlight',
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {},
                child: Text(
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
              backgroundColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {},
              child: const Icon(
                Icons.delete_outline,
                color: Colors.white,
              ),
            ),
          ],
      ),),
      // bottomNavigationBar: BottomAppBar(
      //   surfaceTintColor: Colors.transparent,
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: GestureDetector(
      //           onTap: () {
      //             print('Home');
      //           },
      //           child: Container(
      //             padding: const EdgeInsets.all(16),
      //             child: Center(child: Text("Highlight")),
      //             decoration: BoxDecoration(
      //                 color: Colors.grey[300],
      //                 borderRadius: BorderRadius.circular(10)),
      //           ),
      //         ),
      //       ),
      //       SizedBox(width: 8),
      //       Expanded(
      //         child: GestureDetector(
      //           onTap: () {
      //             print('Home');
      //           },
      //           child: Container(
      //             padding: const EdgeInsets.all(16),
      //             child: Center(child: Text("Add Shoes")),
      //             decoration: BoxDecoration(
      //                 color: Colors.grey[300],
      //                 borderRadius: BorderRadius.circular(10)),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
