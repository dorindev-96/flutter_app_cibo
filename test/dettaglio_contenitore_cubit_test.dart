import 'package:cibo/cubit/dettaglio_contenitore_cubit/dettaglio_contenitore_cubit.dart';
import 'package:cibo/models/entities/contenitore_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'helpers/fake_repositories.dart';

void main() {
  setUpAll(() => initializeDateFormatting());

  final caricato = DateTime(2026, 10, 12, 19, 30);
  late FakeContenitoriRepository repository;

  /// Id of a container just added to the fridge, with every field empty.
  const idNuovo = 2;

  setUp(() {
    repository = FakeContenitoriRepository()
      ..put(
        ContenitoreEntity()
          ..id = 1
          ..nome = 'Ceci'
          ..pesoContenitore = 300
          ..pesoCibo = 900
          ..porzioni = 6
          ..pesoPorzione = 150
          ..dataCaricamento = caricato
          ..nelFreezer = true,
      )
      ..put(
        ContenitoreEntity()
          ..id = idNuovo
          ..dataCaricamento = caricato,
      );
  });

  DettaglioContenitoreCubit crea(String locale, {int id = 1}) {
    final cubit = DettaglioContenitoreCubit(
      contenitoreId: id,
      locale: locale,
      repository: repository,
    );
    addTearDown(cubit.close);
    return cubit;
  }

  group('loading', () {
    test('shows the stored values formatted for the locale', () {
      final cubit = crea('it');

      expect(cubit.state, isA<DettaglioContenitoreLoaded>());
      expect(cubit.nameController.text, 'Ceci');
      expect(cubit.containerWeightController.text, '300');
      expect(cubit.totalWeightController.text, '1200');
      expect(cubit.foodWeightController.text, '900');
      expect(cubit.portionController.text, '6');
      expect(cubit.portionWeightController.text, '150');
      expect(cubit.dataCaricamentoController.text, '12/10/2026');
      expect(cubit.nelFreezer, isTrue);
    });

    test('leaves the fields of a new container empty', () {
      final cubit = crea('it', id: idNuovo);

      for (final controller in [
        cubit.nameController,
        cubit.totalWeightController,
        cubit.containerWeightController,
        cubit.foodWeightController,
        cubit.portionController,
        cubit.portionWeightController,
      ]) {
        expect(controller.text, isEmpty);
      }
      expect(cubit.dataCaricamentoController.text, '12/10/2026');
      expect(cubit.nelFreezer, isFalse);
    });

    test('starts a container not stored yet as stored today', () {
      final cubit = crea('it', id: 0);

      expect(cubit.state, isA<DettaglioContenitoreLoaded>());
      expect(cubit.nameController.text, isEmpty);
      expect(
        DateUtils.isSameDay(cubit.dataCaricamento, DateTime.now()),
        isTrue,
      );
      expect(cubit.nelFreezer, isFalse);
    });

    test('reports a container that does not exist', () {
      final cubit = crea('it', id: 99);

      expect(cubit.state, isA<DettaglioContenitoreError>());
    });

    test('reports a database error', () {
      repository.errore = Exception('database');

      final cubit = crea('it');

      expect(
        cubit.state,
        isA<DettaglioContenitoreError>().having(
          (s) => s.message,
          'message',
          contains('database'),
        ),
      );
    });
  });

  group('calculations', () {
    late DettaglioContenitoreCubit cubit;

    setUp(() => cubit = crea('it', id: idNuovo));

    test('container and total weight give the food weight', () {
      cubit.containerWeightController.text = '300';
      cubit.totalWeightController.text = '1200';

      expect(cubit.foodWeightController.text, '900');
    });

    test('total and food weight give the container weight', () {
      cubit.totalWeightController.text = '1200';
      cubit.foodWeightController.text = '900';

      expect(cubit.containerWeightController.text, '300');
    });

    test('food and container weight give the total weight', () {
      cubit.foodWeightController.text = '900';
      cubit.containerWeightController.text = '300';

      expect(cubit.totalWeightController.text, '1200');
    });

    test('portions split the food weight', () {
      cubit.foodWeightController.text = '900';
      cubit.portionController.text = '6';

      expect(cubit.portionWeightController.text, '150');
    });

    test('portion weight gives the number of portions, rounded', () {
      cubit.foodWeightController.text = '1000';
      cubit.portionWeightController.text = '350';

      expect(cubit.portionController.text, '3');
    });

    test('portions and portion weight give the food and total weight', () {
      cubit.containerWeightController.text = '300';
      cubit.portionController.text = '4';
      cubit.portionWeightController.text = '150';

      expect(cubit.foodWeightController.text, '600');
      expect(cubit.totalWeightController.text, '900');
    });

    test('the same, typing the portions last', () {
      cubit.totalWeightController.text = '900';
      cubit.portionWeightController.text = '150';
      cubit.portionController.text = '4';

      expect(cubit.foodWeightController.text, '600');
      expect(cubit.containerWeightController.text, '300');
    });

    test('a new food weight updates the portion weight', () {
      cubit.foodWeightController.text = '900';
      cubit.portionController.text = '6';

      cubit.foodWeightController.text = '600';

      expect(cubit.portionWeightController.text, '100');
    });

    test('a new total weight updates food and portion weight', () {
      cubit.containerWeightController.text = '300';
      cubit.totalWeightController.text = '1200';
      cubit.portionController.text = '6';

      cubit.totalWeightController.text = '900';

      expect(cubit.foodWeightController.text, '600');
      expect(cubit.portionWeightController.text, '100');
    });

    test('never writes a negative weight', () {
      cubit.containerWeightController.text = '500';
      cubit.totalWeightController.text = '300';

      expect(cubit.foodWeightController.text, isEmpty);
    });

    test('reads decimals typed with a comma or a dot', () {
      cubit.containerWeightController.text = '300';
      cubit.totalWeightController.text = '1000,5';
      expect(cubit.foodWeightController.text, '700,5');

      cubit.totalWeightController.text = '1000.25';
      expect(cubit.foodWeightController.text, '700,25');
    });

    test('formats the results for the locale', () {
      final inglese = crea('en', id: idNuovo);

      cubit.foodWeightController.text = '100';
      cubit.portionController.text = '3';
      inglese.foodWeightController.text = '100';
      inglese.portionController.text = '3';

      expect(cubit.portionWeightController.text, '33,33');
      expect(inglese.portionWeightController.text, '33.33');
    });
  });

  group('storage and date', () {
    test('changes where the food is stored', () {
      final cubit = crea('it');

      cubit.setNelFreezer(false);

      expect(cubit.nelFreezer, isFalse);
      expect(cubit.state, isA<DettaglioContenitoreModificato>());
    });

    test('changes the date, keeping the time when the day is the same', () {
      final cubit = crea('en');

      cubit.setDataCaricamento(DateTime(2026, 10, 12));
      expect(cubit.dataCaricamento, caricato);

      cubit.setDataCaricamento(DateTime(2026, 10, 10));
      expect(cubit.dataCaricamento, DateTime(2026, 10, 10));
      expect(cubit.dataCaricamentoController.text, '10/10/2026');
      expect(cubit.state, isA<DettaglioContenitoreModificato>());
    });
  });

  group('saving', () {
    test('saves decimals, storage and date', () async {
      final cubit = crea('it');
      cubit.totalWeightController.text = '1000,5';
      cubit.setNelFreezer(false);

      await cubit.saveContenitore();

      expect(cubit.state, isA<DettaglioContenitoreSaved>());
      final salvato = repository.contenitori[1]!;
      expect(salvato.nome, 'Ceci');
      expect(salvato.pesoContenitore, 300);
      expect(salvato.pesoCibo, 700.5);
      expect(salvato.porzioni, 6);
      expect(salvato.pesoPorzione, 116.75);
      expect(salvato.nelFreezer, isFalse);
      expect(salvato.dataCaricamento, caricato);
    });

    test('saves empty fields as missing values', () async {
      final cubit = crea('it', id: idNuovo);

      await cubit.saveContenitore();

      final salvato = repository.contenitori[idNuovo]!;
      expect(salvato.nome, isNull);
      expect(salvato.pesoContenitore, isNull);
      expect(salvato.pesoCibo, isNull);
      expect(salvato.porzioni, isNull);
      expect(salvato.pesoPorzione, isNull);
      expect(salvato.dataCaricamento, caricato);
    });

    test('stores a new container only when saved', () async {
      final cubit = crea('it', id: 0);
      cubit.nameController.text = 'Pasta';
      expect(repository.contenitori.keys, [1, idNuovo]);

      await cubit.saveContenitore();

      final salvato = repository.contenitori.values.last;
      expect(salvato.id, isNot(anyOf(0, 1, idNuovo)));
      expect(salvato.nome, 'Pasta');
    });

    test('reports a database error', () async {
      final cubit = crea('it');
      repository.errore = Exception('database');

      await cubit.saveContenitore();

      expect(cubit.state, isA<DettaglioContenitoreError>());
    });
  });
}
