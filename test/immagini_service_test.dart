import 'dart:io';

import 'package:cibo/models/entities/set_contenitori_entity.dart';
import 'package:cibo/services/immagini_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

import 'helpers/cartella_documenti.dart';
import 'helpers/fake_repositories.dart';

void main() {
  late Directory documenti;

  /// Folder where image_picker leaves the photos, cleared by the OS.
  late Directory cache;
  late ImmaginiService service;

  setUp(() async {
    documenti = Directory.systemTemp.createTempSync('cibo_documenti');
    cache = Directory.systemTemp.createTempSync('cibo_cache');
    simulaCartellaDocumenti(documenti.path);
    service = await ImmaginiService.create();
  });

  tearDown(() {
    documenti.deleteSync(recursive: true);
    cache.deleteSync(recursive: true);
  });

  /// A photo just taken with image_picker.
  File fotoScattata([String nome = 'scatto.jpg']) =>
      File(p.join(cache.path, nome))..writeAsBytesSync([1, 2, 3]);

  group('salva', () {
    test('copies the photo into the app documents', () async {
      final foto = fotoScattata();

      final percorso = await service.salva(foto.path);

      expect(p.isRelative(percorso), isTrue);
      expect(p.split(percorso).first, 'immagini_set');
      expect(p.extension(percorso), '.jpg');
      final copia = File(p.join(documenti.path, percorso));
      expect(copia.readAsBytesSync(), [1, 2, 3]);
    });

    test('keeps the copy when the OS clears the cache', () async {
      final foto = fotoScattata();
      final percorso = await service.salva(foto.path);

      foto.deleteSync();

      expect(service.risolvi(percorso)?.readAsBytesSync(), [1, 2, 3]);
    });

    test('returns an empty path when there is no photo', () async {
      expect(await service.salva(''), '');
      expect(await service.salva(p.join(cache.path, 'sparita.jpg')), '');
    });
  });

  group('risolvi', () {
    test('finds a saved photo', () async {
      final percorso = await service.salva(fotoScattata().path);

      expect(service.risolvi(percorso)?.path, p.join(documenti.path, percorso));
    });

    test('still finds photos saved with an absolute path', () {
      final foto = fotoScattata();

      expect(service.risolvi(foto.path)?.path, foto.path);
    });

    test('returns null when there is no photo', () {
      expect(service.risolvi(''), isNull);
      expect(service.risolvi(p.join('immagini_set', 'sparita.jpg')), isNull);
      expect(service.risolvi(p.join(cache.path, 'sparita.jpg')), isNull);
    });
  });

  group('elimina', () {
    test('deletes a saved photo', () async {
      final percorso = await service.salva(fotoScattata().path);

      await service.elimina(percorso);

      expect(service.risolvi(percorso), isNull);
    });

    test('does not delete files outside the app documents', () async {
      final foto = fotoScattata();

      await service.elimina(foto.path);

      expect(foto.existsSync(), isTrue);
    });

    test('ignores photos that do not exist', () async {
      await service.elimina('');
      await service.elimina(p.join('immagini_set', 'sparita.jpg'));
    });
  });

  group('migraPercorsiAssoluti', () {
    late FakeSetContenitoriRepository repository;

    SetContenitoriEntity aggiungiSet(String pathImmagine) {
      final set = SetContenitoriEntity(nome: 'Set', pathImmagine: pathImmagine);
      repository.add(set);
      return set;
    }

    setUp(() => repository = FakeSetContenitoriRepository());

    test('moves the old photos into the app documents', () async {
      final set = aggiungiSet(fotoScattata().path);

      await service.migraPercorsiAssoluti(repository);

      final percorso = repository.sets[set.id]!.pathImmagine;
      expect(p.isRelative(percorso), isTrue);
      expect(service.risolvi(percorso)?.readAsBytesSync(), [1, 2, 3]);
    });

    test('clears the path of photos already deleted by the OS', () async {
      final set = aggiungiSet(p.join(cache.path, 'sparita.jpg'));

      await service.migraPercorsiAssoluti(repository);

      expect(repository.sets[set.id]!.pathImmagine, '');
    });

    test('leaves photos already in the app documents and sets without '
        'photo untouched', () async {
      final percorso = await service.salva(fotoScattata().path);
      final salvato = aggiungiSet(percorso);
      final senzaFoto = aggiungiSet('');

      await service.migraPercorsiAssoluti(repository);

      expect(repository.sets[salvato.id]!.pathImmagine, percorso);
      expect(repository.sets[senzaFoto.id]!.pathImmagine, '');
    });

    test('keeps the old path to retry when the copy fails', () async {
      final foto = fotoScattata();
      final set = aggiungiSet(foto.path);
      // A file in place of the photos folder makes the copy fail.
      File(p.join(documenti.path, 'immagini_set')).writeAsStringSync('');

      await service.migraPercorsiAssoluti(repository);

      expect(repository.sets[set.id]!.pathImmagine, foto.path);
    });
  });
}
