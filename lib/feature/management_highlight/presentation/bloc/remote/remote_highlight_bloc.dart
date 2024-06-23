import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_pemmob/core/data_state.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/usecase/add_highlight.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/usecase/delete_highlight.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/usecase/get_all_highlight.dart';
import 'package:uas_pemmob/feature/management_highlight/domain/usecase/get_non_highlight.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_event.dart';
import 'package:uas_pemmob/feature/management_highlight/presentation/bloc/remote/remote_highlight_state.dart';

class RemoteHighlightBloc extends Bloc<RemoteHighlightEvent, RemoteHighlightState>{
  final GetAllHighlightUseCase getHighlights;
  final DeleteHighlightUseCase deleteHighlight;
  final AddHighlightUseCase addHighlight;
  final GetNonHighlightUseCase getNonHighlights;

  RemoteHighlightBloc(this.getHighlights, this.deleteHighlight, this.addHighlight, this.getNonHighlights) : super(const RemoteHighlightLoading()){
    on<GetHighlights>(onGetHighlights);
    on<DeleteHighlightById>(onDeleteHighlightById);
    on<AddHighlight>(onAddHighlight);
    on<GetNonHighlights>(onGetNonHighlights);
  }

  void onGetHighlights(GetHighlights event, Emitter<RemoteHighlightState> emit) async {
    emit(const RemoteHighlightLoading());
    final result = await getHighlights.call(params: Params(limit: event.limit, offset: event.offset));
    if(result is DataSuccess){
      if(result.data != null && result.data!.isNotEmpty){
        emit(RemoteHighlightDone(result.data!));
      } else {
        emit(const RemoteHighlightError('Data is empty'));
      }
    } else if(result is DataFailed){
      emit(RemoteHighlightError(result.error!));
    }
  }

  void onGetNonHighlights(GetNonHighlights event, Emitter<RemoteHighlightState> emit) async {
    emit(const RemoteHighlightLoading());
    final result = await getNonHighlights.call(params: ParamsNonHighlight(limit: event.limit, offset: event.offset));
    if(result is DataSuccess){
      if(result.data != null && result.data!.isNotEmpty){
        emit(RemoteHighlightDone(result.data!));
      } else {
        emit(const RemoteHighlightError('Data is empty'));
      }
    } else if(result is DataFailed){
      emit(RemoteHighlightError(result.error!));
    }
  }

  void onDeleteHighlightById(DeleteHighlightById event, Emitter<RemoteHighlightState> emit) async {
    emit(const RemoteHighlightLoading());
    final result = await deleteHighlight.call(params: event.id);
    if(result is DataSuccess){
      emit(const RemoteHighlightDone([]));
    } else if(result is DataFailed){
      emit(RemoteHighlightError(result.error!));
    }
  }

  void onAddHighlight(AddHighlight event, Emitter<RemoteHighlightState> emit) async {
    emit(const RemoteHighlightLoading());
    final result = await addHighlight.call(params: event.id);
    if(result is DataSuccess){
      emit(const RemoteHighlightDone([]));
    } else if(result is DataFailed){
      emit(RemoteHighlightError(result.error!));
    }
  }
}