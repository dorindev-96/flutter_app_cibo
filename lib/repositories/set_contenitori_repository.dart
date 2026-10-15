import '../main.dart';
import '../models/entities/set_contenitori_entity.dart';
import '../objectbox/objectbox.g.dart';

/// Repository for managing SetContenitoriEntity objects in ObjectBox.
///
/// Provides CRUD operations for saved container sets (presets).
class SetContenitoriRepository {
  final Box<SetContenitoriEntity> _box;

  SetContenitoriRepository()
    : _box = objectBox.store.box<SetContenitoriEntity>();

  /// Adds a new container set and returns its ID.
  int add(SetContenitoriEntity entity) {
    return _box.put(entity);
  }

  /// Updates an existing container set.
  void put(SetContenitoriEntity entity) {
    _box.put(entity);
  }

  /// Retrieves a single container set by its ID.
  SetContenitoriEntity? get(int id) {
    return _box.get(id);
  }

  /// Retrieves all container sets, sorted alphabetically by name.
  List<SetContenitoriEntity> getAll() {
    final items = _box.getAll();
    items.sort((a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
    return items;
  }

  /// Deletes a container set by its ID. Returns true if successful.
  bool delete(int id) {
    return _box.remove(id);
  }
}
