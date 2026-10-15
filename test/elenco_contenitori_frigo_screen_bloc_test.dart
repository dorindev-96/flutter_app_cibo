import 'package:cibo/bloc/elenco_contenitori_frigo_screen/elenco_contenitori_frigo_screen_bloc.dart';
import 'package:cibo/models/entities/contenitore_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/fake_repositories.dart';

void main() {
  late FakeContenitoriRepository repository;
  late ElencoContenitoriFrigoScreenBloc bloc;

  /// States emitted by the bloc after it was created.
  late List<ElencoContenitoriFrigoScreenState> stati;

  setUp(() {
    repository = FakeContenitoriRepository();
    stati = [];
  });

  tearDown(() => bloc.close());

  /// Creates the bloc and waits for the first load of the list.
  Future<void> creaBloc() async {
    bloc = ElencoContenitoriFrigoScreenBloc(repository: repository);
    bloc.stream.listen(stati.add);
    await pumpEventQueue();
  }

  /// Sends [evento] and returns the states emitted while handling it.
  Future<List<ElencoContenitoriFrigoScreenState>> invia(
    ElencoContenitoriFrigoScreenEvent evento,
  ) async {
    stati.clear();
    bloc.add(evento);
    await pumpEventQueue();
    return stati;
  }

  /// Rice split into 3 portions of 180 g.
  ContenitoreEntity aggiungiRiso() {
    final riso = ContenitoreEntity()
      ..nome = 'Riso'
      ..pesoCibo = 540
      ..porzioni = 3
      ..pesoPorzione = 180;
    repository.add(riso);
    return riso;
  }

  Matcher caricato(List<ContenitoreEntity> contenitori) =>
      isA<ElencoContenitoriFrigoScreenLoaded>().having(
        (s) => s.contenitori,
        'contenitori',
        contenitori,
      );

  test('loads the containers in the fridge when created', () async {
    final riso = aggiungiRiso();

    await creaBloc();

    expect(stati, [
      isA<ElencoContenitoriFrigoScreenLoading>(),
      caricato([riso]),
    ]);
  });

  test('shows an error when the containers cannot be loaded', () async {
    repository.errore = Exception('database');

    await creaBloc();

    expect(stati, [
      isA<ElencoContenitoriFrigoScreenLoading>(),
      isA<ElencoContenitoriFrigoScreenError>().having(
        (s) => s.message,
        'message',
        contains('database'),
      ),
    ]);
  });

  test('adds an empty container stored today and opens it', () async {
    await creaBloc();

    final emessi = await invia(AddContenitoreEvent());

    final nuovo = repository.contenitori.values.single;
    expect(emessi, [
      isA<ElencoContenitoriFrigoScreenEdit>()
          .having((s) => s.id, 'id', nuovo.id)
          .having((s) => s.isNew, 'isNew', isTrue),
    ]);
    expect(DateUtils.isSameDay(nuovo.dataCaricamento, DateTime.now()), isTrue);
    expect(nuovo.nelFreezer, isFalse);
  });

  test('opens an existing container', () async {
    final riso = aggiungiRiso();
    await creaBloc();

    final emessi = await invia(EditContenitoreEvent(id: riso.id));

    expect(emessi, [
      isA<ElencoContenitoriFrigoScreenEdit>()
          .having((s) => s.id, 'id', riso.id)
          .having((s) => s.isNew, 'isNew', isFalse),
    ]);
  });

  test('deletes a container and reloads the list', () async {
    final riso = aggiungiRiso();
    await creaBloc();

    final emessi = await invia(DeleteContenitoreEvent(id: riso.id));

    expect(repository.contenitori, isEmpty);
    expect(emessi.last, caricato([]));
  });

  group('Gnam!', () {
    test('removes a portion and its weight', () async {
      final riso = aggiungiRiso();
      await creaBloc();

      final emessi = await invia(GnamPorzioneEvent(id: riso.id));

      expect(riso.porzioni, 2);
      expect(riso.pesoCibo, 360);
      expect(riso.pesoPorzione, 180);
      expect(emessi.last, caricato([riso]));
    });

    test('removes the container with the last portion', () async {
      final riso = aggiungiRiso()..porzioni = 1;
      await creaBloc();

      final emessi = await invia(GnamPorzioneEvent(id: riso.id));

      expect(repository.contenitori, isEmpty);
      expect(emessi.last, caricato([]));
    });

    test('does nothing when the portions are unknown', () async {
      final senzaPorzioni = aggiungiRiso()..porzioni = null;
      await creaBloc();

      await invia(GnamPorzioneEvent(id: senzaPorzioni.id));
      await invia(GnamPorzioneEvent(id: 99));

      expect(repository.contenitori.values, [senzaPorzioni]);
      expect(senzaPorzioni.pesoCibo, 540);
    });
  });
}
