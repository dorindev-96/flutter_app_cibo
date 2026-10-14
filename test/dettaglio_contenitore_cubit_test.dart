import 'package:cibo/cubit/dettaglio_contenitore_cubit/dettaglio_contenitore_cubit.dart';
import 'package:cibo/models/entities/contenitore_entity.dart';
import 'package:cibo/repositories/contenitori_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// In-memory repository, so the cubit can be tested without ObjectBox.
class _FakeContenitoriRepository implements ContenitoriRepository {
  final contenitori = <int, ContenitoreEntity>{};

  @override
  ContenitoreEntity? get(int id) => contenitori[id];

  @override
  void put(ContenitoreEntity entity) => contenitori[entity.id] = entity;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  setUpAll(() => initializeDateFormatting());

  final caricato = DateTime(2026, 10, 12, 19, 30);
  late _FakeContenitoriRepository repository;

  setUp(() {
    repository = _FakeContenitoriRepository()
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
      );
  });

  DettaglioContenitoreCubit crea(String locale) => DettaglioContenitoreCubit(
    contenitoreId: 1,
    locale: locale,
    repository: repository,
  );

  test('shows the stored values formatted for the locale', () async {
    final cubit = crea('it');

    expect(cubit.containerWeightController.text, '300');
    expect(cubit.totalWeightController.text, '1200');
    expect(cubit.foodWeightController.text, '900');
    expect(cubit.portionController.text, '6');
    expect(cubit.portionWeightController.text, '150');
    expect(cubit.dataCaricamentoController.text, '12/10/2026');
    expect(cubit.nelFreezer, isTrue);
    await cubit.close();
  });

  test('reads decimals typed with a comma and recalculates', () async {
    final cubit = crea('it');

    cubit.totalWeightController.text = '1000,5';

    expect(cubit.foodWeightController.text, '700,5');
    expect(cubit.portionWeightController.text, '116,75');
    await cubit.close();
  });

  test('saves decimals, storage and date', () async {
    final cubit = crea('it');
    cubit.totalWeightController.text = '1000,5';
    cubit.setNelFreezer(false);

    await cubit.saveContenitore();

    final salvato = repository.contenitori[1]!;
    expect(salvato.pesoCibo, 700.5);
    expect(salvato.pesoPorzione, 116.75);
    expect(salvato.nelFreezer, isFalse);
    expect(salvato.dataCaricamento, caricato);
    await cubit.close();
  });

  test('changes the date, keeping the time when the day is the same', () async {
    final cubit = crea('en');

    cubit.setDataCaricamento(DateTime(2026, 10, 12));
    expect(cubit.dataCaricamento, caricato);

    cubit.setDataCaricamento(DateTime(2026, 10, 10));
    expect(cubit.dataCaricamento, DateTime(2026, 10, 10));
    expect(cubit.dataCaricamentoController.text, '10/10/2026');
    await cubit.close();
  });
}
