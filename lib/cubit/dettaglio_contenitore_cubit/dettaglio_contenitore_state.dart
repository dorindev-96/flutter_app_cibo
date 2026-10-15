part of 'dettaglio_contenitore_cubit.dart';

@immutable
sealed class DettaglioContenitoreState {}

final class DettaglioContenitoreInitial extends DettaglioContenitoreState {}

final class DettaglioContenitoreLoading extends DettaglioContenitoreState {}

final class DettaglioContenitoreLoaded extends DettaglioContenitoreState {
  final ContenitoreEntity contenitore;

  DettaglioContenitoreLoaded(this.contenitore);
}

/// Emitted when a field that is not a text field (storage or date) changes,
/// so that the form is rebuilt.
final class DettaglioContenitoreModificato extends DettaglioContenitoreState {}

final class DettaglioContenitoreSaved extends DettaglioContenitoreState {}

final class DettaglioContenitoreError extends DettaglioContenitoreState {
  final String message;

  DettaglioContenitoreError(this.message);
}
