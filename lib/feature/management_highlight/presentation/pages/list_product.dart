import 'package:flutter/material.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_bloc.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_state.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/widgets/product_checklist.dart';
class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<RemoteHighlightBloc>(context).add(GetNonHighlights(
          limit: 100, offset: 0)); // Sesuaikan dengan email yang tepat
    });
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', height: 30),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<RemoteHighlightBloc>(context)
              .add(GetNonHighlights(limit: 100, offset: 0));
        },
        child: BlocBuilder<RemoteHighlightBloc, RemoteHighlightState>(
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
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          "List Products",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ProductListChecklist(highlights: state.highlights)
                    ],
                  ),
                ),
              );
            } return const SizedBox();
          }
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Row(children: [
      //     Expanded(
      //       child: FloatingActionButton(
      //         onPressed: () {
      //           Navigator.pushNamed(context, '/list_product');
      //         },
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         backgroundColor: Colors.grey[900],
      //         child: const Text(
      //           "Add Product to Highlight",
      //           style: TextStyle(
      //             color: Colors.white,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ]),
      // ),
    );
  }
}
