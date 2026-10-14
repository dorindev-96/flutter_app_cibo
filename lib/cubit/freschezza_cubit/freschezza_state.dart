part of 'freschezza_cubit.dart';

/// Shelf life, in days, of the food in the fridge and in the freezer
@immutable
final class FreschezzaState {
  const FreschezzaState({
    required this.giorniFrigo,
    required this.giorniFreezer,
  });

  /// Days food keeps in the fridge
  final int giorniFrigo;

  /// Days food keeps in the freezer
  final int giorniFreezer;

  /// Returns the shelf life of food stored in the freezer or in the fridge.
  int giorniPer({required bool nelFreezer}) =>
      nelFreezer ? giorniFreezer : giorniFrigo;
}
