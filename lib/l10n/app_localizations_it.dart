// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get containerListPageTitle => 'Contenitori in Frigo';

  @override
  String get containerDetailNewTitle => 'Nuovo Contenitore';

  @override
  String get containerDetailEditTitle => 'Modifica Contenitore';

  @override
  String get containerDetailNameLabel => 'Nome Contenitore';

  @override
  String get containerDetailContainerWeightLabel => 'Peso Contenitore (g)';

  @override
  String get containerDetailTotalWeightLabel => 'Peso Totale (g)';

  @override
  String get containerDetailFoodWeightLabel => 'Peso Cibo (g)';

  @override
  String get containerDetailPortionLabel => 'Porzione';

  @override
  String get containerDetailPortionWeightLabel => 'Peso Porzione (g)';

  @override
  String get containerDetailSaveButton => 'Salva Contenitore';

  @override
  String containerPortionWeight(String portion) {
    return 'Porzione: $portion g';
  }

  @override
  String containerNrPortion(String nrPortion) {
    return 'N. Porzioni: $nrPortion';
  }

  @override
  String containerUploadDate(String date) {
    return 'Data Caricamento: $date';
  }

  @override
  String get gen_No_Food => 'Non hai nulla da mangiare 😢';

  @override
  String gen_Gen_Error(String error) {
    return 'Errore: $error';
  }

  @override
  String get gen_Confirm_Delete_Title => 'Conferma Eliminazione';

  @override
  String gen_Confirm_Delete_Message(String name) {
    return 'Vuoi eliminare \"$name\"?';
  }

  @override
  String get gen_Cancel => 'Annulla';

  @override
  String get gen_Delete => 'Elimina';

  @override
  String get no_name => 'Senza Nome';

  @override
  String get settings_title => 'Impostazioni';

  @override
  String get settings_theme => 'Tema';

  @override
  String get settings_help => 'Aiuto';

  @override
  String get help_title => 'Aiuto';

  @override
  String get help_intro => 'Vediamo come utilizzare al meglio Cibo.';

  @override
  String get help_thanks => 'Grazie per aver scaricato Cibo.';

  @override
  String get navTabFridge => 'Frigo';

  @override
  String get navTabContainers => 'Contenitori';

  @override
  String get navTabSettings => 'Impostazioni';

  @override
  String get containerSetsPageTitle => 'Set Contenitori';

  @override
  String get containerSetsEmpty => 'Nessun set di contenitori salvato';

  @override
  String get containerSetsAddTitle => 'Aggiungi Set Contenitore';

  @override
  String get containerSetsNameLabel => 'Nome';

  @override
  String get containerSetsWeightLabel => 'Peso (g)';

  @override
  String get containerSetsNameRequired => 'Inserisci un nome';

  @override
  String get containerSetsWeightInvalid => 'Inserisci un peso maggiore di 0';

  @override
  String get containerSetsImageLabel => 'Immagine';

  @override
  String get containerSetsSaveButton => 'Salva';

  @override
  String get containerSetsImageCamera => 'Fotocamera';

  @override
  String get containerSetsImageGallery => 'Galleria';

  @override
  String get containerSetsImageChoose => 'Scegli Origine Immagine';

  @override
  String containerSetsWeight(String weight) {
    return 'Peso: $weight g';
  }

  @override
  String get presetPickerTitle => 'Seleziona un Contenitore';

  @override
  String get presetPickerEmpty =>
      'Nessun contenitore preimpostato.\nAggiungili dalla scheda Contenitori.';

  @override
  String get settings_theme_system => 'Sistema';

  @override
  String get settings_theme_light => 'Chiaro';

  @override
  String get settings_theme_dark => 'Scuro';

  @override
  String get settings_freshness_fridge => 'Durata in frigo';

  @override
  String get settings_freshness_freezer => 'Durata in freezer';

  @override
  String get settings_freshness_note =>
      'Il bollino accanto a ogni pietanza diventa arancione quando va consumata presto e rosso quando supera la durata impostata.';

  @override
  String get settings_freshness_days_label => 'Giorni';

  @override
  String get gen_Save => 'Salva';

  @override
  String freshnessDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days giorni',
      one: '1 giorno',
    );
    return '$_temp0';
  }

  @override
  String freshnessAge(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days giorni fa',
      one: 'Ieri',
      zero: 'Oggi',
    );
    return '$_temp0';
  }

  @override
  String get freshnessFresh => 'Fresco';

  @override
  String get freshnessExpiring => 'Da consumare presto';

  @override
  String get freshnessExpired => 'Scaduto';

  @override
  String get containerDetailStorageLabel => 'Conservazione';

  @override
  String get storageFridge => 'Frigo';

  @override
  String get storageFreezer => 'Freezer';

  @override
  String get containerDetailDateLabel => 'Data Caricamento';

  @override
  String get guideWelcomeTitle => 'Ti diamo il benvenuto in Cibo';

  @override
  String get guideWelcomeText =>
      'Cucini in anticipo? Cibo ti dice quante porzioni hai e quanti grammi prelevare ogni volta. Tutto offline, sul tuo telefono.';

  @override
  String get guideCalcTitle => 'Pesa, al resto pensa Cibo';

  @override
  String get guideCalcText =>
      'Tocca + e pesa il contenitore vuoto e poi pieno: Cibo calcola il peso del cibo. Inserisci le porzioni o il peso di una porzione e l\'altro valore si calcola da solo.';

  @override
  String get guideGnamTitle => 'Gnam!';

  @override
  String get guideGnamText =>
      'Quando mangi una porzione tocca le posate: porzioni e peso si aggiornano da soli. Tocca il piatto per modificarlo o aggiornare il peso totale.';

  @override
  String get guideFreshTitle => 'Sempre fresco';

  @override
  String get guideFreshText =>
      'Il bollino mostra da quanti giorni il piatto è conservato: verde se è fresco, arancione se va mangiato presto, rosso se ha superato la durata. Per ogni piatto scegli frigo o freezer; le durate si cambiano nelle Impostazioni.';

  @override
  String get guideSetsTitle => 'I tuoi contenitori';

  @override
  String get guideSetsText =>
      'Salva nella scheda Contenitori quelli che usi più spesso, con foto e peso. Quando aggiungi un piatto, tocca l\'icona nel campo Peso Contenitore per non doverlo ripesare.';

  @override
  String get guideLabelContainer => 'Contenitore';

  @override
  String get guideLabelFood => 'Cibo';

  @override
  String get guideLabelTotal => 'Totale';

  @override
  String get guideLabelPortions => 'Porzioni';

  @override
  String get guideLabelPortion => 'Porzione';

  @override
  String get guideSampleDish => 'Riso basmati';

  @override
  String get guideSampleContainer => 'Contenitore blu';

  @override
  String get guideSkip => 'Salta';

  @override
  String get guideNext => 'Avanti';

  @override
  String get guideStart => 'Inizia';
}
