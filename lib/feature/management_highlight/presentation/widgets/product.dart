import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:uas_pemmob/core/constant.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/entities/highlight.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_bloc.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_event.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_state.dart';

class ProductList extends StatefulWidget {
  final List<HighlightEntity> highlights;

  const ProductList({required this.highlights, Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool _isLoading = false;

  Future<void> _waitForBlocOperation(
      RemoteHighlightBloc bloc, RemoteHighlightEvent event) async {
    final completer = Completer<void>();
    final subscription = bloc.stream.listen((state) {
      if (state is RemoteHighlightDone || state is RemoteHighlightError) {
        completer.complete();
      }
    });
    bloc.add(event);
    await completer.future;
    await subscription.cancel();
  }

  void _onDeleteHighlight(HighlightEntity highlight) async {
    setState(() {
      _isLoading = true;
    });

    final bloc = BlocProvider.of<RemoteHighlightBloc>(context);

    await _waitForBlocOperation(bloc, DeleteHighlightById(id: highlight.id));
    await _waitForBlocOperation(bloc, GetHighlights(limit: 100, offset: 0));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.highlights.length,
      itemBuilder: (context, index) {
        final highlight = widget.highlights[index];
        final formattedPrice =
            NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                .format(highlight.price);

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                          image: DecorationImage(
                            image:
                                NetworkImage('$Api/uploads/${highlight.image}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
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
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              formattedPrice,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  onPressed:
                      _isLoading ? null : () => _onDeleteHighlight(highlight),
                  iconSize: 30,
                  icon: const Icon(Icons.remove),
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
