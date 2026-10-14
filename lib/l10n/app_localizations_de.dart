// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get containerListPageTitle => 'Behälter im Kühlschrank';

  @override
  String get containerDetailNewTitle => 'Neuer Behälter';

  @override
  String get containerDetailEditTitle => 'Behälter bearbeiten';

  @override
  String get containerDetailNameLabel => 'Behältername';

  @override
  String get containerDetailContainerWeightLabel => 'Behältergewicht (g)';

  @override
  String get containerDetailTotalWeightLabel => 'Gesamtgewicht (g)';

  @override
  String get containerDetailFoodWeightLabel => 'Lebensmittelgewicht (g)';

  @override
  String get containerDetailPortionLabel => 'Portion';

  @override
  String get containerDetailPortionWeightLabel => 'Portionsgewicht (g)';

  @override
  String get containerDetailSaveButton => 'Behälter speichern';

  @override
  String containerPortionWeight(String portion) {
    return 'Portion: $portion g';
  }

  @override
  String containerNrPortion(String nrPortion) {
    return 'Anzahl Portionen: $nrPortion';
  }

  @override
  String containerUploadDate(String date) {
    return 'Uploaddatum: $date';
  }

  @override
  String get gen_No_Food => 'Du hast nichts zu essen 😢';

  @override
  String gen_Gen_Error(String error) {
    return 'Fehler: $error';
  }

  @override
  String get gen_Confirm_Delete_Title => 'Löschung bestätigen';

  @override
  String gen_Confirm_Delete_Message(String name) {
    return 'Möchtest du \"$name\" löschen?';
  }

  @override
  String get gen_Cancel => 'Abbrechen';

  @override
  String get gen_Delete => 'Löschen';

  @override
  String get no_name => 'Ohne Namen';

  @override
  String get settings_title => 'Einstellungen';

  @override
  String get settings_theme => 'Design';

  @override
  String get settings_help => 'Hilfe';

  @override
  String get help_title => 'Hilfe';

  @override
  String get help_intro => 'Sehen wir uns an, wie man Cibo am besten nutzt.';

  @override
  String get help_step1 => 'Beginnen wir mit der Eingabe des Gerichtsnamens';

  @override
  String get help_step2 =>
      'und sofort können wir das Gewicht des Behälters eingeben';

  @override
  String get help_step2_note => ', mit Deckel falls vorhanden.';

  @override
  String get help_step3 =>
      'Wenn wir noch nicht alles bereit haben, können wir speichern';

  @override
  String get help_step3_note =>
      'und fortfahren, sobald wir das Gericht zubereitet haben.';

  @override
  String get help_step4 =>
      'Sobald alles bereit ist, füllen wir den Behälter und wiegen ihn, mit Deckel falls vorhanden, und geben sein Gesamtgewicht ein';

  @override
  String get help_step5 => 'wir werden sehen, dass';

  @override
  String get help_step5_note =>
      'automatisch berechnet wird und bei Änderung von';

  @override
  String get help_step5_end => 'entsprechend aktualisiert wird.';

  @override
  String get help_step6 =>
      'Jetzt können wir wählen, ob wir die Anzahl der Portionen eingeben';

  @override
  String get help_step6_note => 'oder das Gewicht einer einzelnen Portion';

  @override
  String get help_step6_end =>
      ', die Eingabe einer aktualisiert automatisch die andere.';

  @override
  String get help_step7 =>
      'Wir können jetzt alles mit der Speichern-Taste speichern';

  @override
  String get help_gnam =>
      'Wenn wir essen, können wir anstatt die Werte manuell zu ändern die Gnam-Taste verwenden';

  @override
  String get help_gnam_note =>
      'die eine Portion aus dem Behälter entfernt und alle Daten aktualisiert.';

  @override
  String get help_thanks => 'Danke, dass du Cibo heruntergeladen hast.';

  @override
  String get navTabFridge => 'Kühlschrank';

  @override
  String get navTabContainers => 'Behälter';

  @override
  String get navTabSettings => 'Einstellungen';

  @override
  String get containerSetsPageTitle => 'Behälter-Sets';

  @override
  String get containerSetsEmpty => 'Noch keine Behälter-Sets gespeichert';

  @override
  String get containerSetsAddTitle => 'Behälter-Set hinzufügen';

  @override
  String get containerSetsNameLabel => 'Name';

  @override
  String get containerSetsWeightLabel => 'Gewicht (g)';

  @override
  String get containerSetsImageLabel => 'Bild';

  @override
  String get containerSetsSaveButton => 'Speichern';

  @override
  String get containerSetsImageCamera => 'Kamera';

  @override
  String get containerSetsImageGallery => 'Galerie';

  @override
  String get containerSetsImageChoose => 'Bildquelle wählen';

  @override
  String containerSetsWeight(String weight) {
    return 'Gewicht: $weight g';
  }

  @override
  String get presetPickerTitle => 'Behälter auswählen';

  @override
  String get presetPickerEmpty =>
      'Noch keine Behälter-Vorlagen gespeichert.\nFüge sie über den Behälter-Tab hinzu.';

  @override
  String get settings_theme_system => 'System';

  @override
  String get settings_theme_light => 'Hell';

  @override
  String get settings_theme_dark => 'Dunkel';

  @override
  String get settings_freshness_fridge => 'Haltbarkeit im Kühlschrank';

  @override
  String get settings_freshness_freezer => 'Haltbarkeit im Gefrierschrank';

  @override
  String get settings_freshness_note =>
      'Die Markierung neben jedem Gericht wird orange, wenn es bald gegessen werden sollte, und rot, wenn die eingestellte Haltbarkeit überschritten ist.';

  @override
  String get settings_freshness_days_label => 'Tage';

  @override
  String get gen_Save => 'Speichern';

  @override
  String freshnessDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days Tage',
      one: '1 Tag',
    );
    return '$_temp0';
  }

  @override
  String freshnessAge(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Vor $days Tagen',
      one: 'Gestern',
      zero: 'Heute',
    );
    return '$_temp0';
  }

  @override
  String get freshnessFresh => 'Frisch';

  @override
  String get freshnessExpiring => 'Bald essen';

  @override
  String get freshnessExpired => 'Abgelaufen';

  @override
  String get containerDetailStorageLabel => 'Aufbewahrung';

  @override
  String get storageFridge => 'Kühlschrank';

  @override
  String get storageFreezer => 'Gefrierschrank';

  @override
  String get containerDetailDateLabel => 'Uploaddatum';

  @override
  String get help_freshness =>
      'Neben dem Namen jedes Gerichts zeigt eine Markierung, seit wie vielen Tagen es aufbewahrt wird: grün, wenn es frisch ist, orange, wenn es bald gegessen werden sollte, rot, wenn die in den Einstellungen festgelegte Haltbarkeit überschritten ist – unterschiedlich für Kühlschrank und Gefrierschrank.';
}
