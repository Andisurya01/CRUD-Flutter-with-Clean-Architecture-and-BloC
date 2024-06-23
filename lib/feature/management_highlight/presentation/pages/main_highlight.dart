import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_bloc.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_state.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/widgets/product.dart';
import '../bloc/remote/remote_highlight_event.dart';

class MainHiglight extends StatefulWidget {
  const MainHiglight({super.key});

  @override
  State<MainHiglight> createState() => _MainHiglightState();
}

class _MainHiglightState extends State<MainHiglight> {
  
  @override
  void initState() {
    super.initState();
    // Load highlights when the page first loads
    BlocProvider.of<RemoteHighlightBloc>(context)
        .add(GetHighlights(limit: 100, offset: 0));
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<RemoteHighlightBloc>(context).add(GetHighlights(
          limit: 100, offset: 0)); // Sesuaikan dengan email yang tepat
    });
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
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<RemoteHighlightBloc>(context)
              .add(GetHighlights(limit: 100, offset: 0));
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
                        "Highlight List",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Meneruskan data highlights ke widget ProductList
                    ProductList(highlights: state.highlights),
                  ],
                ),
              ),
            );
          } return const SizedBox();
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/list_product');
          // Navigator.push(
          //   context,
          //   PageRouteBuilder(
          //     pageBuilder: (context, animation, secondaryAnimation) => ListProduct(), // ganti dengan halaman tujuan Anda
          //     transitionDuration: Duration.zero,
          //     reverseTransitionDuration: Duration.zero,
          //   ),
          // );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.grey[900],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
