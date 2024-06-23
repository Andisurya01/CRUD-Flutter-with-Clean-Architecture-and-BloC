import 'package:equatable/equatable.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/entities/highlight.dart';

abstract class RemoteHighlightState extends Equatable{
  final List<HighlightEntity>? highlights;
  final Object? error;
  const RemoteHighlightState({this.highlights, this.error});

  @override
  List<Object?> get props => [highlights, error];
}

class RemoteHighlightInitial extends RemoteHighlightState {
  RemoteHighlightInitial() : super(highlights: []);
}

class RemoteHighlightLoading extends RemoteHighlightState {
  const RemoteHighlightLoading();
}

class RemoteHighlightDone extends RemoteHighlightState {
  @override
  // ignore: overridden_fields
  final List<HighlightEntity> highlights;
  const RemoteHighlightDone(this.highlights) : super(highlights: highlights);
}

class RemoteHighlightError extends RemoteHighlightState{
  const RemoteHighlightError(Object error) : super(error: error);
}