import 'dart:io';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uas_pemmob/feature/main_menu/domain/entities/product.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/bloc/remote/remote_product_bloc.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/bloc/remote/remote_product_event.dart';
import 'package:uas_pemmob/feature/main_menu/presentation/bloc/remote/remote_product_state.dart';

class EditProduct extends StatefulWidget {
  final ProductEntity product;
  const EditProduct({
    super.key,
    required this.product,
  });

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late double _price;
  File? _imageFile;
  late int _stock;
  late int _size;
  late int _rating;
  late String? _category = widget.product.category;
  bool _isPicking = false;
  bool _isLoading = false;

  void _pickImage() async {
    if (_isPicking) return; // Cek apakah sedang dalam proses pemilihan
    setState(() {
      _isPicking = true; // Set status menjadi aktif
    });

    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        setState(() {
          _imageFile = File(result.files.single.path!);
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print('Error picking file: $e');
    } finally {
      setState(() {
        _isPicking = false; // Set status menjadi tidak aktif
      });
    }
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

  void _submitForm() async {
    // if (_imageFile == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Please pick an image')),
    //   );
    //   return;
    // }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Image: $_imageFile');
      print('Name: $_name');
      final product = ProductEntity(
        id: 0,
        name: _name.isEmpty ? widget.product.name : _name,
        description:
            _description.isEmpty ? widget.product.description : _description,
        price: _price == 0.0 ? widget.product.price : _price.toInt(),
        stock: _stock == 0 ? widget.product.stock : _stock,
        image: '',
        size: _size == 0 ? widget.product.size : _size,
        rating: _rating == 0 ? widget.product.rating : _rating,
        category: _category,
        imageFile: _imageFile,
      );

      setState(() {
        _isLoading = true;
      });

      final bloc = BlocProvider.of<RemoteProductBloc>(context);
      await _waitForBlocOperation(
          bloc, UpdateShoes(id: widget.product.id, shoes: product));
      await _waitForBlocOperation(bloc, FilterByCategory(category: 'women'));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushNamed(context, '/main');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Image",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[500],
                        ),
                        child: _imageFile != null
                            ? Image.file(
                                _imageFile!,
                                fit: BoxFit.cover,
                              )
                            : const Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 50,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: widget.product.name,
                      ),
                      onSaved: (value) {
                        _name = value ?? '';
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: widget.product.description,
                      ),
                      onSaved: (value) {
                        _description = value ?? '';
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Price",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: widget.product.price.toString(),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _price = double.tryParse(value ?? '0.0') ?? 0.0;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Stock",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: widget.product.stock.toString(),
                                ),
                                keyboardType: TextInputType.number,
                                onSaved: (value) {
                                  _stock = int.tryParse(value ?? '0') ?? 0;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Size",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: widget.product.size.toString(),
                                ),
                                keyboardType: TextInputType.number,
                                onSaved: (value) {
                                  _size = int.tryParse(value ?? '0') ?? 0;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Rating",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: widget.product.rating.toString(),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _rating = int.tryParse(value ?? '0') ?? 0;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      value: _category, // Nilai awal kategori
                      items: ['men', 'women', 'kids']
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select category";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _category = value;
                        });
                      },
                      onSaved: (value) {
                        _category = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(130, 30),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _isLoading ? null : _submitForm,
                          child: const Icon(Icons.arrow_forward_sharp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            ModalBarrier(
              color: Colors.black.withOpacity(0.5),
              dismissible: false,
            ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
