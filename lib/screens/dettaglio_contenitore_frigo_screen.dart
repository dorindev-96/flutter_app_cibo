import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/dettaglio_contenitore_cubit/dettaglio_contenitore_cubit.dart';
import '../l10n/app_localizations.dart';
import '../utils/formato.dart';
import '../widgets/input_dettaglio_contenitore_widget.dart';
import '../widgets/seleziona_set_contenitore_bottom_sheet.dart';

/// Keyboard for the weight fields, which accept decimal numbers.
const _tastieraDecimale = TextInputType.numberWithOptions(decimal: true);

/// A screen that displays the details of a refrigerator container.
///
/// The [idContenitore] parameter specifies the unique identifier of the container.
class DettaglioContenitoreFrigoScreen extends StatelessWidget {
  const DettaglioContenitoreFrigoScreen({
    super.key,
    required this.idContenitore,
    this.isNew = false,
  });

  final int idContenitore;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => DettaglioContenitoreCubit(
        contenitoreId: idContenitore,
        locale: appLoc.localeName,
      ),
      child: BlocConsumer<DettaglioContenitoreCubit, DettaglioContenitoreState>(
        listener: (context, state) {
          if (state is DettaglioContenitoreSaved) {
            Navigator.of(context).pop();
          } else if (state is DettaglioContenitoreError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is DettaglioContenitoreLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final cubit = context.read<DettaglioContenitoreCubit>();
          final theme = Theme.of(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                isNew
                    ? appLoc.containerDetailNewTitle
                    : appLoc.containerDetailEditTitle,
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 24.h,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputDettaglioContenitoreWidget(
                            key: Key('name_$idContenitore'),
                            label: appLoc.containerDetailNameLabel,
                            controller: cubit.nameController,
                          ),
                          InputDettaglioContenitoreWidget(
                            key: Key('contweight_$idContenitore'),
                            label: appLoc.containerDetailContainerWeightLabel,
                            controller: cubit.containerWeightController,
                            keyboardType: _tastieraDecimale,
                            inputFormatters: const [DecimaleInputFormatter()],
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.inventory_2_outlined,
                                color: theme.colorScheme.primary,
                              ),
                              tooltip: appLoc.presetPickerTitle,
                              onPressed: () =>
                                  _openPresetPicker(context, cubit),
                            ),
                          ),
                          InputDettaglioContenitoreWidget(
                            key: Key('totalweight_$idContenitore'),
                            label: appLoc.containerDetailTotalWeightLabel,
                            controller: cubit.totalWeightController,
                            keyboardType: _tastieraDecimale,
                            inputFormatters: const [DecimaleInputFormatter()],
                          ),
                          InputDettaglioContenitoreWidget(
                            key: Key('foodweight_$idContenitore'),
                            label: appLoc.containerDetailFoodWeightLabel,
                            controller: cubit.foodWeightController,
                            keyboardType: _tastieraDecimale,
                            inputFormatters: const [DecimaleInputFormatter()],
                          ),
                          InputDettaglioContenitoreWidget(
                            key: Key('portion_$idContenitore'),
                            label: appLoc.containerDetailPortionLabel,
                            controller: cubit.portionController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          InputDettaglioContenitoreWidget(
                            key: Key('portionweight_$idContenitore'),
                            label: appLoc.containerDetailPortionWeightLabel,
                            controller: cubit.portionWeightController,
                            keyboardType: _tastieraDecimale,
                            inputFormatters: const [DecimaleInputFormatter()],
                          ),
                          _ConservazioneSelector(
                            label: appLoc.containerDetailStorageLabel,
                            nelFreezer: cubit.nelFreezer,
                            onChanged: cubit.setNelFreezer,
                          ),
                          InputDettaglioContenitoreWidget(
                            key: Key('date_$idContenitore'),
                            label: appLoc.containerDetailDateLabel,
                            controller: cubit.dataCaricamentoController,
                            readOnly: true,
                            onTap: () => _pickDate(context, cubit),
                            suffixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 24.h,
                  ),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () => cubit.saveContenitore(),
                      child: Text(appLoc.containerDetailSaveButton),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Opens a bottom sheet to pick a saved container preset.
  ///
  /// When a preset is selected, the container weight field is populated
  /// with the preset's tare weight.
  void _openPresetPicker(
    BuildContext context,
    DettaglioContenitoreCubit cubit,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SelezionaSetContenitoreBottomSheet(
        onSelected: (preset) {
          cubit.containerWeightController.text = formattaNumero(
            preset.pesoInGrammi,
            cubit.locale,
          );
        },
      ),
    );
  }

  /// Opens a date picker to change the day the food was stored.
  Future<void> _pickDate(
    BuildContext context,
    DettaglioContenitoreCubit cubit,
  ) async {
    final now = DateTime.now();
    final iniziale = cubit.dataCaricamento.isAfter(now)
        ? now
        : cubit.dataCaricamento;
    final primaData = DateTime(2000);
    final data = await showDatePicker(
      context: context,
      initialDate: iniziale,
      // The picker requires the initial date not to be before the first one.
      firstDate: iniziale.isBefore(primaData) ? iniziale : primaData,
      lastDate: now,
    );
    if (data != null) cubit.setDataCaricamento(data);
  }
}

/// Selector for where the food is stored: fridge or freezer.
class _ConservazioneSelector extends StatelessWidget {
  const _ConservazioneSelector({
    required this.label,
    required this.nelFreezer,
    required this.onChanged,
  });

  final String label;
  final bool nelFreezer;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: double.maxFinite,
            child: SegmentedButton<bool>(
              segments: [
                ButtonSegment(
                  value: false,
                  icon: const Icon(Icons.kitchen_outlined),
                  label: Text(appLoc.storageFridge),
                ),
                ButtonSegment(
                  value: true,
                  icon: const Icon(Icons.ac_unit),
                  label: Text(appLoc.storageFreezer),
                ),
              ],
              selected: {nelFreezer},
              onSelectionChanged: (selezione) => onChanged(selezione.first),
            ),
          ),
        ],
      ),
    );
  }
}
