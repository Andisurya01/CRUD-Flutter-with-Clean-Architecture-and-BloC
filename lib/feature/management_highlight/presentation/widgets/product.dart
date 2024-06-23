import 'package:flutter/material.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/entities/highlight.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_bloc.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_event.dart';

class ProductList extends StatelessWidget {
  final List<HighlightEntity> highlights;

  const ProductList({required this.highlights, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: highlights.length,
      itemBuilder: (context, index) {
        final highlight = highlights[index];
        return InkWell(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset('assets/kids.png',
                            height: 100, width: 100),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            highlight.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("Rp. ${highlight.price}"),  // Sesuaikan dengan atribut harga dari highlight
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    onPressed: () {
                      BlocProvider.of<RemoteHighlightBloc>(context).add(DeleteHighlightById(id: highlight.id));
                      BlocProvider.of<RemoteHighlightBloc>(context).add(GetHighlights(
          limit: 10, offset: 0)); // Sesuaikan dengan email yang tepat
                    },
                    iconSize: 30,
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.grey.shade900,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
