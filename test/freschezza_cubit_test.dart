import 'package:cibo/constants/freschezza_constants.dart';
import 'package:cibo/cubit/freschezza_cubit/freschezza_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('uses the default shelf life when nothing is saved', () async {
    final cubit = await FreschezzaCubit.create();

    expect(cubit.state.giorniFrigo, defaultGiorniFrigo);
    expect(cubit.state.giorniFreezer, defaultGiorniFreezer);
    await cubit.close();
  });

  test('loads the saved shelf life', () async {
    SharedPreferences.setMockInitialValues({
      giorniFrigoKey: 5,
      giorniFreezerKey: 60,
    });

    final cubit = await FreschezzaCubit.create();

    expect(cubit.state.giorniFrigo, 5);
    expect(cubit.state.giorniFreezer, 60);
    await cubit.close();
  });

  test('changes the fridge shelf life, keeping the freezer one', () async {
    SharedPreferences.setMockInitialValues({giorniFreezerKey: 60});
    final cubit = await FreschezzaCubit.create();

    await cubit.setGiorniFrigo(4);

    expect(cubit.state.giorniFrigo, 4);
    expect(cubit.state.giorniFreezer, 60);
    final riavviato = await FreschezzaCubit.create();
    expect(riavviato.state.giorniFrigo, 4);

    await cubit.close();
    await riavviato.close();
  });

  test('changes the freezer shelf life, keeping the fridge one', () async {
    SharedPreferences.setMockInitialValues({giorniFrigoKey: 5});
    final cubit = await FreschezzaCubit.create();

    await cubit.setGiorniFreezer(120);

    expect(cubit.state.giorniFreezer, 120);
    expect(cubit.state.giorniFrigo, 5);
    final riavviato = await FreschezzaCubit.create();
    expect(riavviato.state.giorniFreezer, 120);

    await cubit.close();
    await riavviato.close();
  });

  test('gives the shelf life of the fridge or of the freezer', () {
    const durate = FreschezzaState(giorniFrigo: 3, giorniFreezer: 90);

    expect(durate.giorniPer(nelFreezer: false), 3);
    expect(durate.giorniPer(nelFreezer: true), 90);
  });
}
