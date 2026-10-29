import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../repositories/set_contenitori_repository.dart';

/// Service that stores the photos of the container sets.
///
/// The files returned by image_picker live in a temporary/cache directory
/// that the OS can clear at any time, so photos are copied into the app's
/// documents directory when a set is saved. Only the path relative to that
/// directory is persisted, because on iOS the absolute path of the app
/// container changes after an update.
class ImmaginiService {
  ImmaginiService._(this._docsPath);

  /// Sub-folder of the documents directory that holds the photos.
  static const _cartella = 'immagini_set';

  final String _docsPath;

  /// Creates the service, resolving the app's documents directory.
  static Future<ImmaginiService> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    return ImmaginiService._(docsDir.path);
  }

  /// Copies the image at [percorsoOrigine] into the app storage.
  ///
  /// Returns the relative path to persist, or an empty string when there is
  /// no image to copy.
  Future<String> salva(String percorsoOrigine) async {
    if (percorsoOrigine.isEmpty) return '';
    final origine = File(percorsoOrigine);
    if (!await origine.exists()) return '';

    await Directory(p.join(_docsPath, _cartella)).create(recursive: true);
    final percorso = p.join(
      _cartella,
      '${DateTime.now().microsecondsSinceEpoch}${p.extension(percorsoOrigine)}',
    );
    await origine.copy(p.join(_docsPath, percorso));
    return percorso;
  }

  /// Returns the file of a persisted image, or `null` if it does not exist.
  ///
  /// Absolute paths saved by older versions of the app are still supported.
  File? risolvi(String percorso) {
    if (percorso.isEmpty) return null;
    final file = File(
      p.isAbsolute(percorso) ? percorso : p.join(_docsPath, percorso),
    );
    return file.existsSync() ? file : null;
  }

  /// Deletes a persisted image stored by this service.
  Future<void> elimina(String percorso) async {
    if (percorso.isEmpty || p.isAbsolute(percorso)) return;
    final file = File(p.join(_docsPath, percorso));
    if (await file.exists()) await file.delete();
  }

  /// Deletes a temporary photo left by image_picker, outside the app storage.
  ///
  /// Errors are ignored: the OS clears that folder anyway.
  static Future<void> eliminaTemporanea(String percorso) async {
    if (percorso.isEmpty) return;
    try {
      final file = File(percorso);
      if (await file.exists()) await file.delete();
    } catch (e) {
      debugPrint('Temporary image delete error: $e');
    }
  }

  /// Moves the photos saved by older versions (absolute paths into the
  /// image_picker cache) into the app storage.
  ///
  /// Photos already removed by the OS cannot be recovered, so their path is
  /// cleared. A photo that fails to copy is retried at the next start.
  Future<void> migraPercorsiAssoluti(
    SetContenitoriRepository repository,
  ) async {
    for (final set in repository.getAll()) {
      if (!p.isAbsolute(set.pathImmagine)) continue;
      try {
        set.pathImmagine = await salva(set.pathImmagine);
        repository.put(set);
      } catch (e) {
        // Never stop the app from starting because of a photo.
        debugPrint('Image migration error: $e');
      }
    }
  }
}
