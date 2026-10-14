import 'package:objectbox/objectbox.dart';

/// An entity representing a container in the refrigerator.
///
/// The [ContenitoreEntity] class includes fields for the container's
/// name, weight, food weight, number of portions, and portion weight.
@Entity()
class ContenitoreEntity {
  @Id()
  int id = 0;

  String? nome;
  double? pesoContenitore;
  double? pesoCibo;
  int? porzioni;
  double? pesoPorzione;
  @Property(type: PropertyType.date)
  DateTime? dataCaricamento;

  /// Whether the food is stored in the freezer instead of the fridge.
  bool nelFreezer = false;
}
