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
  String get help_step1 => 'Iniziamo inserendo il nome della pietanza';

  @override
  String get help_step2 => 'e subito possiamo inserire il peso del contenitore';

  @override
  String get help_step2_note => ', con il coperchio se previsto.';

  @override
  String get help_step3 =>
      'A questo punto se non abbiamo ancora tutto pronto possiamo salvare';

  @override
  String get help_step3_note =>
      'e proseguire una volta che abbiamo preparato la pietanza.';

  @override
  String get help_step4 =>
      'Una volta che abbiamo tutto pronto, riempiamo il contenitore e lo pesiamo, con coperchio se previsto, e inseriamo il suo peso totale';

  @override
  String get help_step5 => 'vedremo che';

  @override
  String get help_step5_note => 'si valorizza automaticamente e variandolo';

  @override
  String get help_step5_end => 'si aggiornerà di conseguenza.';

  @override
  String get help_step6 =>
      'A questo punto possiamo scegliere se inserire il nr di porzioni';

  @override
  String get help_step6_note => 'o quant\'è il peso di una singola porzione';

  @override
  String get help_step6_end =>
      ', inserendone una l\'altra si aggiornerà di conseguenza.';

  @override
  String get help_step7 => 'Possiamo ora salvare tutto usando il tasto salva';

  @override
  String get help_gnam =>
      'Quando consumiamo il nostro pasto, anziché modificare i valori a mano possiamo utilizzare il tasto Gnam';

  @override
  String get help_gnam_note =>
      'che andrà a rimuovere una porzione dal contenitore e aggiornerà tutti i dati.';

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
  String get help_freshness =>
      'Accanto al nome di ogni pietanza un bollino indica da quanti giorni è conservata: verde se è fresca, arancione se va consumata presto, rosso se ha superato la durata impostata nelle Impostazioni, diversa per frigo e freezer.';
}
