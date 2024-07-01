import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_bloc.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_state.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/widgets/product.dart';
import '../bloc/remote/remote_highlight_event.dart';

class MainHighlight extends StatefulWidget {
  const MainHighlight({super.key});

  @override
  State<MainHighlight> createState() => _MainHighlightState();
}

class _MainHighlightState extends State<MainHighlight> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load highlights when the page first loads
    BlocProvider.of<RemoteHighlightBloc>(context)
        .add(GetHighlights(limit: 100, offset: 0));
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/logo.png', height: 30),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<RemoteHighlightBloc, RemoteHighlightState>(
            builder: (context, state) {
          if (state is RemoteHighlightLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RemoteHighlightError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.error.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          } else if (state is RemoteHighlightDone) {
            final filteredHighlights = state.highlights.where((highlight) {
              return highlight.name
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase());
            }).toList();

            return SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<RemoteHighlightBloc>(context)
                      .add(GetHighlights(limit: 100, offset: 0));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          "Highlight List",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search by name...',

                          border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              ),
                          // fillColor: Colors.white,
                          // filled: true,
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          _onSearchChanged();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Meneruskan data highlights yang sudah difilter ke widget ProductList
                      ProductList(highlights: filteredHighlights),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Text('data');
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/list_product');
            // Fetch highlights again after returning from /list_product
            BlocProvider.of<RemoteHighlightBloc>(context)
                .add(GetHighlights(limit: 100, offset: 0));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.grey[900],
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
