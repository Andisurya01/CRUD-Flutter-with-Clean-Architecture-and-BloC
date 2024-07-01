abstract class RemoteHighlightEvent {
  const RemoteHighlightEvent();

  List<Object> get props => [];
}

class GetHighlights extends RemoteHighlightEvent{
  final int limit;
  final int offset;

  GetHighlights({required this.limit, required this.offset});

  @override
  List<Object> get props => [limit, offset];
}

class GetNonHighlights extends RemoteHighlightEvent{
  final int limit;
  final int offset;

  GetNonHighlights({required this.limit, required this.offset});

  @override
  List<Object> get props => [limit, offset];
}

class DeleteHighlightById extends RemoteHighlightEvent {
  final int id;

  DeleteHighlightById({required this.id});

  @override
  List<Object> get props => [id];
}

class AddHighlight extends RemoteHighlightEvent {
  final int id;

  AddHighlight({required this.id});

  @override
  List<Object> get props => [id];
}