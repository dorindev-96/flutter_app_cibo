import 'dart:io';

import 'package:cibo/bloc/elenco_contenitori_screen/elenco_contenitori_screen_bloc.dart';
import 'package:cibo/main.dart';
import 'package:cibo/models/entities/set_contenitori_entity.dart';
import 'package:cibo/services/immagini_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

import 'helpers/cartella_documenti.dart';
import 'helpers/fake_repositories.dart';

void main() {
  late Directory documenti;
  late FakeSetContenitoriRepository repository;
  late ElencoContenitoriScreenBloc bloc;

  /// States emitted by the bloc after it was created.
  late List<ElencoContenitoriScreenState> stati;

  setUp(() async {
    documenti = Directory.systemTemp.createTempSync('cibo_documenti');
    simulaCartellaDocumenti(documenti.path);
    immaginiService = await ImmaginiService.create();
    repository = FakeSetContenitoriRepository();
    stati = [];
  });

  tearDown(() async {
    await bloc.close();
    documenti.deleteSync(recursive: true);
  });

  /// Creates the bloc and waits for the first load of the list.
  Future<void> creaBloc() async {
    bloc = ElencoContenitoriScreenBloc(repository: repository);
    bloc.stream.listen(stati.add);
    await pumpEventQueue();
  }

  /// Sends [evento] and returns the states emitted while handling it.
  Future<List<ElencoContenitoriScreenState>> invia(
    ElencoContenitoriScreenEvent evento,
  ) async {
    stati.clear();
    bloc.add(evento);
    await pumpEventQueue();
    return stati;
  }

  Matcher caricato(List<SetContenitoriEntity> sets) =>
      isA<ElencoContenitoriScreenLoaded>().having(
        (s) => s.setContenitori,
        'setContenitori',
        sets,
      );

  test('loads the saved containers when created', () async {
    final set = SetContenitoriEntity(nome: 'Vetro', pesoInGrammi: 312);
    repository.add(set);

    await creaBloc();

    expect(stati, [
      isA<ElencoContenitoriScreenLoading>(),
      caricato([set]),
    ]);
  });

  test('shows an error when the containers cannot be loaded', () async {
    repository.errore = Exception('database');

    await creaBloc();

    expect(stati, [
      isA<ElencoContenitoriScreenLoading>(),
      isA<ElencoContenitoriScreenError>().having(
        (s) => s.message,
        'message',
        contains('database'),
      ),
    ]);
  });

  test('adds a container with a copy of its photo', () async {
    await creaBloc();
    final cache = Directory.systemTemp.createTempSync('cibo_cache');
    addTearDown(() => cache.deleteSync(recursive: true));
    final foto = File(p.join(cache.path, 'scatto.jpg'))
      ..writeAsBytesSync([1, 2, 3]);

    final emessi = await invia(
      AddSetContenitoreEvent(
        nome: 'Vetro',
        pathImmagine: foto.path,
        pesoInGrammi: 312,
      ),
    );

    final set = repository.sets.values.single;
    expect(set.nome, 'Vetro');
    expect(set.pesoInGrammi, 312);
    expect(p.isRelative(set.pathImmagine), isTrue);
    expect(immaginiService.risolvi(set.pathImmagine), isNotNull);
    expect(emessi.last, caricato([set]));
  });

  test('adds a container without photo', () async {
    await creaBloc();

    await invia(
      AddSetContenitoreEvent(nome: 'Vetro', pathImmagine: '', pesoInGrammi: 0),
    );

    expect(repository.sets.values.single.pathImmagine, '');
  });

  test('deletes a container together with its photo', () async {
    final foto = File(p.join(documenti.path, 'scatto.jpg'))
      ..writeAsBytesSync([1, 2, 3]);
    final percorso = await immaginiService.salva(foto.path);
    final set = SetContenitoriEntity(nome: 'Vetro', pathImmagine: percorso);
    repository.add(set);
    await creaBloc();

    final emessi = await invia(DeleteSetContenitoreEvent(id: set.id));

    expect(repository.sets, isEmpty);
    expect(immaginiService.risolvi(percorso), isNull);
    expect(emessi.last, caricato([]));
  });
}
