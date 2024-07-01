import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uas_pemmob/core/constant.dart';
import 'package:uas_pemmob/feature/main_menu/domain/entities/product.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/bloc/remote/remote_product_bloc.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/bloc/remote/remote_product_event.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/bloc/remote/remote_product_state.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/pages/update_product.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/widgets/verif_delete.dart';

class DetailShoes extends StatefulWidget {
  final ProductEntity product;

  const DetailShoes({super.key, required this.product});

  @override
  State<DetailShoes> createState() => _DetailShoesState();
}

class _DetailShoesState extends State<DetailShoes> {
  late int productId;
  bool _isLoading = false;
  bool isLove = false;

  @override
  void initState() {
    super.initState();
    // print(widget.product.id);
    setState(() {
      productId = widget.product.id;
    });
    // print(productId);
  }

  Future<void> _waitForBlocOperation(
      RemoteProductBloc bloc, RemoteProductEvent event) async {
    final completer = Completer<void>();
    final subscription = bloc.stream.listen((state) {
      if (state is RemoteProductDone || state is RemoteProductError) {
        completer.complete();
      }
    });
    bloc.add(event);
    await completer.future;
    await subscription.cancel();
  }

  void _onDeleteHighlight(ProductEntity highlight) async {
    setState(() {
      _isLoading = true;
    });

    final bloc = BlocProvider.of<RemoteProductBloc>(context);

    // Menunggu operasi AddHighlight selesai
    await _waitForBlocOperation(bloc, DeleteShoesById(id: productId));

    // Setelah AddHighlight selesai, dapatkan highlights yang tidak terpilih
    await _waitForBlocOperation(bloc, FilterByCategory(category: 'women'));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final formattedPrice =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
            .format(product.price);
    print(product.id);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', height: 30),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 100),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.grey.shade200,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                        '${Api}/uploads/${product.image}'), // Gunakan URL gambar dari produk
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                        child: Text(
                          product.category ??
                              'category', // Gunakan kategori produk
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8),
                        child: Text(
                          product.name ?? 'name', // Gunakan nama produk
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          formattedPrice, // Gunakan harga produk
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isLove = !isLove;
                        });
                      },
                      icon: isLove
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                              size: 30,
                            ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'stock: ${product.stock}', // Gunakan ukuran produk
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'size: ${product.size}', // Gunakan ukuran produk
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                  )),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Text(
                  "Description : ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  product.description ??
                      'description', // Gunakan deskripsi produk
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: FloatingActionButton(
                heroTag: 'edit_shoes',
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProduct(product: product)));
                },
                child: const Text(
                  "Edit Shoes",
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
              heroTag: 'delete_shoes',
              backgroundColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: _isLoading
                  ? null
                  : () =>
                      verifeDelete(context, () => _onDeleteHighlight(product)),

              // BlocProvider.of<RemoteProductBloc>(context)
              //     .add(DeleteShoesById(id: productId));
              // BlocProvider.of<RemoteProductBloc>(context)
              //     .add(FilterByCategory(category: "women"));

              // Navigator.pop(context);
              // },
              child: const Icon(
                Icons.delete_outline,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
