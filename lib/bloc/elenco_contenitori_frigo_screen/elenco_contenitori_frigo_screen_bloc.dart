import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/entities/contenitore_entity.dart';
import '../../repositories/contenitori_repository.dart';

part 'elenco_contenitori_frigo_screen_event.dart';
part 'elenco_contenitori_frigo_screen_state.dart';

class ElencoContenitoriFrigoScreenBloc
    extends
        Bloc<
          ElencoContenitoriFrigoScreenEvent,
          ElencoContenitoriFrigoScreenState
        > {
  final ContenitoriRepository _contenitoriRepository;

  ElencoContenitoriFrigoScreenBloc({ContenitoriRepository? repository})
    : _contenitoriRepository = repository ?? ContenitoriRepository(),
      super(ElencoContenitoriFrigoScreenInitial()) {
    on<LoadContenitoriEvent>(_loadContenitori);
    on<AddContenitoreEvent>(_addContenitore);
    on<EditContenitoreEvent>(_editContenitore);
    on<DeleteContenitoreEvent>(_deleteContenitore);
    on<GnamPorzioneEvent>(_gnamPorzione);

    add(LoadContenitoriEvent());
  }

  /// Loads the list of "contenitori" from the repository and updates the state accordingly.
  Future<void> _loadContenitori(
    LoadContenitoriEvent event,
    Emitter<ElencoContenitoriFrigoScreenState> emit,
  ) async {
    try {
      emit(ElencoContenitoriFrigoScreenLoading());

      final contenitori = _contenitoriRepository.getAllSorted();

      emit(ElencoContenitoriFrigoScreenLoaded(contenitori));
    } catch (e) {
      emit(ElencoContenitoriFrigoScreenError(e.toString()));
    }
  }

  Future<void> _addContenitore(
    AddContenitoreEvent event,
    Emitter<ElencoContenitoriFrigoScreenState> emit,
  ) async {
    try {
      final newContenitore = ContenitoreEntity();
      newContenitore.dataCaricamento = DateTime.now();

      final newId = _contenitoriRepository.add(newContenitore);
      emit(ElencoContenitoriFrigoScreenEdit(id: newId, isNew: true));
    } catch (e) {
      emit(ElencoContenitoriFrigoScreenError(e.toString()));
    }
  }

  Future<void> _editContenitore(
    EditContenitoreEvent event,
    Emitter<ElencoContenitoriFrigoScreenState> emit,
  ) async {
    try {
      emit(ElencoContenitoriFrigoScreenEdit(id: event.id, isNew: false));
    } catch (e) {
      emit(ElencoContenitoriFrigoScreenError(e.toString()));
    }
  }

  Future<void> _deleteContenitore(
    DeleteContenitoreEvent event,
    Emitter<ElencoContenitoriFrigoScreenState> emit,
  ) async {
    try {
      _contenitoriRepository.delete(event.id);
      add(LoadContenitoriEvent());
    } catch (e) {
      emit(ElencoContenitoriFrigoScreenError(e.toString()));
    }
  }

  Future<void> _gnamPorzione(
    GnamPorzioneEvent event,
    Emitter<ElencoContenitoriFrigoScreenState> emit,
  ) async {
    try {
      final contenitore = _contenitoriRepository.getById(event.id);
      if (contenitore != null && (contenitore.porzioni ?? 0) > 0) {
        final nuovePorzioni = (contenitore.porzioni ?? 0) - 1;

        if (nuovePorzioni == 0) {
          // Se le porzioni diventano 0, elimina il contenitore
          _contenitoriRepository.delete(event.id);
        } else {
          // Altrimenti aggiorna i valori sottraendo il peso di una porzione
          contenitore.porzioni = nuovePorzioni;
          final pesoPorzione = contenitore.pesoPorzione ?? 0;
          contenitore.pesoCibo = (contenitore.pesoCibo ?? 0) - pesoPorzione;
          _contenitoriRepository.put(contenitore);
        }
      }
      add(LoadContenitoriEvent());
    } catch (e) {
      emit(ElencoContenitoriFrigoScreenError(e.toString()));
    }
  }
}
