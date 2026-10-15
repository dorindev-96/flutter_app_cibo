import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../cubit/freschezza_cubit/freschezza_cubit.dart';
import '../l10n/app_localizations.dart';
import '../models/freschezza.dart';

import '../widgets/contenitore_frigo_widget.dart';
import '../bloc/elenco_contenitori_frigo_screen/elenco_contenitori_frigo_screen_bloc.dart';

/// Screen that displays the list of containers in the fridge
///
/// Uses localized strings for the title and includes a floating action button
/// to add new containers. The list is sorted by freshness, most urgent first,
/// and is reloaded when the app returns to the foreground so that the
/// freshness of the food stays up to date.
class ElencoContenitoriFrigoScreen extends StatefulWidget {
  const ElencoContenitoriFrigoScreen({super.key});

  @override
  State<ElencoContenitoriFrigoScreen> createState() =>
      _ElencoContenitoriFrigoScreenState();
}

class _ElencoContenitoriFrigoScreenState
    extends State<ElencoContenitoriFrigoScreen> {
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    _lifecycleListener = AppLifecycleListener(
      onResume: () => context.read<ElencoContenitoriFrigoScreenBloc>().add(
        LoadContenitoriEvent(),
      ),
    );
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(appLoc.containerListPageTitle)),
      body:
          BlocConsumer<
            ElencoContenitoriFrigoScreenBloc,
            ElencoContenitoriFrigoScreenState
          >(listener: _listener, builder: _builder),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewContenitore(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  _listener(
    BuildContext context,
    ElencoContenitoriFrigoScreenState state,
  ) async {
    if (state is ElencoContenitoriFrigoScreenEdit) {
      await context.push(
        '/dettaglio-contenitore-frigo/${state.id}?isNew=${state.isNew}',
      );
      if (context.mounted) {
        context.read<ElencoContenitoriFrigoScreenBloc>().add(
          LoadContenitoriEvent(),
        );
      }
    }
  }

  Widget _builder(
    BuildContext context,
    ElencoContenitoriFrigoScreenState state,
  ) {
    final appLoc = AppLocalizations.of(context)!;

    if (state is ElencoContenitoriFrigoScreenLoaded) {
      final contenitori = state.contenitori;

      if (contenitori.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.kitchen_outlined,
                size: 64.w,
                color: Theme.of(context).colorScheme.outline,
              ),
              SizedBox(height: 16.h),
              Text(
                appLoc.gen_No_Food,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        );
      }

      final theme = Theme.of(context);
      final durate = context.watch<FreschezzaCubit>().state;
      final oggi = DateTime.now();

      // Most urgent first: fewest days left until the end of the shelf life.
      final elementi = [
        for (final contenitore in contenitori)
          (
            contenitore: contenitore,
            freschezza: Freschezza.calcola(
              dataCaricamento: contenitore.dataCaricamento ?? oggi,
              durataGiorni: durate.giorniPer(
                nelFreezer: contenitore.nelFreezer,
              ),
              oggi: oggi,
            ),
          ),
      ];
      elementi.sort((a, b) {
        final perUrgenza = a.freschezza.giorniRimanenti.compareTo(
          b.freschezza.giorniRimanenti,
        );
        if (perUrgenza != 0) return perUrgenza;
        final perData = (a.contenitore.dataCaricamento ?? oggi).compareTo(
          b.contenitore.dataCaricamento ?? oggi,
        );
        return perData != 0
            ? perData
            : a.contenitore.id.compareTo(b.contenitore.id);
      });

      return ListView.builder(
        padding: EdgeInsets.only(top: 8.h, bottom: 88.h),
        itemCount: elementi.length,
        itemBuilder: (context, index) {
          final (:contenitore, :freschezza) = elementi[index];
          return Dismissible(
            key: Key('dismissible_${contenitore.id}'),
            direction: DismissDirection.horizontal,
            background: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.error,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Icon(
                Icons.delete_outline,
                color: theme.colorScheme.onError,
              ),
            ),
            secondaryBackground: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.error,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Icon(
                Icons.delete_outline,
                color: theme.colorScheme.onError,
              ),
            ),
            confirmDismiss: (direction) =>
                _confirmDelete(context, contenitore.nome),
            onDismissed: (direction) {
              context.read<ElencoContenitoriFrigoScreenBloc>().add(
                DeleteContenitoreEvent(id: contenitore.id),
              );
            },
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => _editContenitore(context, contenitore.id),
              child: ContenitoreFrigoWidget(
                dataInserimento: contenitore.dataCaricamento ?? oggi,
                freschezza: freschezza,
                nelFreezer: contenitore.nelFreezer,
                nomeContenitore: contenitore.nome ?? appLoc.no_name,
                porzioniDisponibili: contenitore.porzioni ?? 0,
                pesoPorzione: contenitore.pesoPorzione ?? 0,
                gman: contenitore.porzioni != null
                    ? () => _gnam(context, contenitore.id)
                    : null,
              ),
            ),
          );
        },
      );
    }

    if (state is ElencoContenitoriFrigoScreenError) {
      return Center(child: Text(appLoc.gen_Gen_Error(state.message)));
    }

    return Center(child: CircularProgressIndicator());
  }

  _addNewContenitore(BuildContext context) async {
    context.read<ElencoContenitoriFrigoScreenBloc>().add(AddContenitoreEvent());
  }

  _editContenitore(BuildContext context, int id) async {
    context.read<ElencoContenitoriFrigoScreenBloc>().add(
      EditContenitoreEvent(id: id),
    );
  }

  _gnam(BuildContext context, int id) async {
    context.read<ElencoContenitoriFrigoScreenBloc>().add(
      GnamPorzioneEvent(id: id),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context, String? nome) {
    final appLoc = AppLocalizations.of(context)!;
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(appLoc.gen_Confirm_Delete_Title),
        content: Text(
          appLoc.gen_Confirm_Delete_Message(nome ?? appLoc.no_name),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(appLoc.gen_Cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(appLoc.gen_Delete),
          ),
        ],
      ),
    );
  }
}
