import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../main.dart';
import '../../models/entities/set_contenitori_entity.dart';
import '../../repositories/set_contenitori_repository.dart';
import '../../services/immagini_service.dart';

part 'elenco_contenitori_screen_event.dart';
part 'elenco_contenitori_screen_state.dart';

/// BLoC for managing the container sets list screen.
///
/// Handles loading, adding, and deleting container set presets.
class ElencoContenitoriScreenBloc
    extends Bloc<ElencoContenitoriScreenEvent, ElencoContenitoriScreenState> {
  final SetContenitoriRepository _repository;

  ElencoContenitoriScreenBloc({SetContenitoriRepository? repository})
    : _repository = repository ?? SetContenitoriRepository(),
      super(ElencoContenitoriScreenInitial()) {
    on<LoadSetContenitoriEvent>(_loadSetContenitori);
    on<AddSetContenitoreEvent>(_addSetContenitore);
    on<DeleteSetContenitoreEvent>(_deleteSetContenitore);

    add(LoadSetContenitoriEvent());
  }

  Future<void> _loadSetContenitori(
    LoadSetContenitoriEvent event,
    Emitter<ElencoContenitoriScreenState> emit,
  ) async {
    try {
      emit(ElencoContenitoriScreenLoading());
      final items = _repository.getAll();
      emit(ElencoContenitoriScreenLoaded(items));
    } catch (e) {
      emit(ElencoContenitoriScreenError(e.toString()));
    }
  }

  Future<void> _addSetContenitore(
    AddSetContenitoreEvent event,
    Emitter<ElencoContenitoriScreenState> emit,
  ) async {
    try {
      // The picked photo lives in a temporary folder: keep a persistent copy.
      final pathImmagine = await immaginiService.salva(event.pathImmagine);
      await ImmaginiService.eliminaTemporanea(event.pathImmagine);
      final entity = SetContenitoriEntity(
        nome: event.nome,
        pathImmagine: pathImmagine,
        pesoInGrammi: event.pesoInGrammi,
      );
      _repository.add(entity);
      add(LoadSetContenitoriEvent());
    } catch (e) {
      emit(ElencoContenitoriScreenError(e.toString()));
    }
  }

  Future<void> _deleteSetContenitore(
    DeleteSetContenitoreEvent event,
    Emitter<ElencoContenitoriScreenState> emit,
  ) async {
    try {
      final entity = _repository.get(event.id);
      _repository.delete(event.id);
      if (entity != null) {
        try {
          await immaginiService.elimina(entity.pathImmagine);
        } catch (e) {
          // The set is already deleted: a leftover photo is no reason to
          // show an error.
          debugPrint('Image delete error: $e');
        }
      }
      add(LoadSetContenitoriEvent());
    } catch (e) {
      // Showing the error removes the list, with the item swiped away: a
      // reload would bring that item back into the tree.
      emit(ElencoContenitoriScreenError(e.toString()));
    }
  }
}
