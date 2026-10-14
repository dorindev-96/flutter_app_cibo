import 'package:objectbox/objectbox.dart';

/// An entity representing a saved container set (preset).
///
/// Users can save their containers once (with name, image, and tare weight),
/// then select them when adding food to the fridge, avoiding manual re-entry.
@Entity()
class SetContenitoriEntity {
  @Id()
  int id = 0;

  /// Display name of the container set (e.g. "Blue Tupperware")
  String nome;

  /// Path of the container's photo, relative to the app documents directory
  /// (see `ImmaginiService`). Older versions stored an absolute path.
  String pathImmagine;

  /// Tare weight of the container in grams
  double pesoInGrammi;

  SetContenitoriEntity({
    this.id = 0,
    this.nome = '',
    this.pathImmagine = '',
    this.pesoInGrammi = 0,
  });
}
