import 'dart:math';

import 'package:cibo/models/entities/contenitore_entity.dart';
import 'package:cibo/models/entities/set_contenitori_entity.dart';
import 'package:cibo/repositories/contenitori_repository.dart';
import 'package:cibo/repositories/set_contenitori_repository.dart';

/// In-memory [ContenitoriRepository], so the logic can be tested without
/// ObjectBox. Like ObjectBox, it assigns a new id to entities with id 0.
class FakeContenitoriRepository implements ContenitoriRepository {
  final contenitori = <int, ContenitoreEntity>{};
  int _ultimoId = 0;

  /// When set, every operation throws it, to test error handling.
  Object? errore;

  void _verificaErrore() {
    if (errore case final errore?) throw errore;
  }

  @override
  int add(ContenitoreEntity entity) {
    _verificaErrore();
    if (entity.id == 0) entity.id = _ultimoId + 1;
    _ultimoId = max(_ultimoId, entity.id);
    contenitori[entity.id] = entity;
    return entity.id;
  }

  @override
  void put(ContenitoreEntity entity) => add(entity);

  @override
  ContenitoreEntity? get(int id) {
    _verificaErrore();
    return contenitori[id];
  }

  @override
  ContenitoreEntity? getById(int id) => get(id);

  /// Returns the containers in insertion order.
  @override
  List<ContenitoreEntity> getAllSorted() {
    _verificaErrore();
    return contenitori.values.toList();
  }

  @override
  bool delete(int id) {
    _verificaErrore();
    return contenitori.remove(id) != null;
  }
}

/// In-memory [SetContenitoriRepository], so the logic can be tested without
/// ObjectBox. Like ObjectBox, it assigns a new id to entities with id 0.
class FakeSetContenitoriRepository implements SetContenitoriRepository {
  final sets = <int, SetContenitoriEntity>{};
  int _ultimoId = 0;

  /// When set, every operation throws it, to test error handling.
  Object? errore;

  void _verificaErrore() {
    if (errore case final errore?) throw errore;
  }

  @override
  int add(SetContenitoriEntity entity) {
    _verificaErrore();
    if (entity.id == 0) entity.id = _ultimoId + 1;
    _ultimoId = max(_ultimoId, entity.id);
    sets[entity.id] = entity;
    return entity.id;
  }

  @override
  void put(SetContenitoriEntity entity) => add(entity);

  @override
  SetContenitoriEntity? get(int id) {
    _verificaErrore();
    return sets[id];
  }

  /// Returns the sets in insertion order.
  @override
  List<SetContenitoriEntity> getAll() {
    _verificaErrore();
    return sets.values.toList();
  }

  @override
  bool delete(int id) {
    _verificaErrore();
    return sets.remove(id) != null;
  }
}
