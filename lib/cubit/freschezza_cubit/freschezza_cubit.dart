import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/freschezza_constants.dart';

part 'freschezza_state.dart';

/// Cubit holding how many days food keeps in the fridge and in the freezer.
///
/// The durations are chosen by the user in the settings and persisted in
/// shared preferences.
class FreschezzaCubit extends Cubit<FreschezzaState> {
  FreschezzaCubit._(super.initialState);

  /// Creates a FreschezzaCubit with the durations loaded from storage.
  static Future<FreschezzaCubit> create() async {
    final prefs = await SharedPreferences.getInstance();
    return FreschezzaCubit._(
      FreschezzaState(
        giorniFrigo: prefs.getInt(giorniFrigoKey) ?? defaultGiorniFrigo,
        giorniFreezer: prefs.getInt(giorniFreezerKey) ?? defaultGiorniFreezer,
      ),
    );
  }

  /// Sets how many days food keeps in the fridge.
  Future<void> setGiorniFrigo(int giorni) async {
    emit(
      FreschezzaState(giorniFrigo: giorni, giorniFreezer: state.giorniFreezer),
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(giorniFrigoKey, giorni);
  }

  /// Sets how many days food keeps in the freezer.
  Future<void> setGiorniFreezer(int giorni) async {
    emit(
      FreschezzaState(giorniFrigo: state.giorniFrigo, giorniFreezer: giorni),
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(giorniFreezerKey, giorni);
  }
}
