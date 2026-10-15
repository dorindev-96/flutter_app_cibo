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
  String get guideWelcomeTitle => 'Willkommen bei Cibo';

  @override
  String get guideWelcomeText =>
      'Kochst du vor? Cibo sagt dir, wie viele Portionen du hast und wie viele Gramm du jedes Mal entnehmen sollst. Alles offline, auf deinem Handy.';

  @override
  String get guideCalcTitle => 'Wiegen – den Rest macht Cibo';

  @override
  String get guideCalcText =>
      'Tippe auf + und wiege den Behälter leer und dann voll: Cibo berechnet das Gewicht des Essens. Gib die Portionen oder das Gewicht einer Portion ein, der andere Wert wird automatisch berechnet.';

  @override
  String get guideGnamTitle => 'Gnam!';

  @override
  String get guideGnamText =>
      'Wenn du eine Portion isst, tippe auf das Besteck: Portionen und Gewicht werden automatisch aktualisiert. Tippe auf das Gericht, um es zu bearbeiten oder sein Gesamtgewicht zu aktualisieren.';

  @override
  String get guideFreshTitle => 'Immer frisch';

  @override
  String get guideFreshText =>
      'Die Markierung zeigt, seit wie vielen Tagen das Gericht aufbewahrt wird: grün, wenn es frisch ist, orange, wenn es bald gegessen werden sollte, rot, wenn die Haltbarkeit überschritten ist. Wähle für jedes Gericht Kühlschrank oder Gefrierschrank; die Haltbarkeit änderst du in den Einstellungen.';

  @override
  String get guideSetsTitle => 'Deine Behälter';

  @override
  String get guideSetsText =>
      'Speichere die Behälter, die du am häufigsten nutzt, mit Foto und Gewicht im Tab Behälter. Wenn du ein Gericht hinzufügst, tippe auf das Symbol im Feld Behältergewicht, damit du ihn nicht erneut wiegen musst.';

  @override
  String get guideLabelContainer => 'Behälter';

  @override
  String get guideLabelFood => 'Essen';

  @override
  String get guideLabelTotal => 'Gesamt';

  @override
  String get guideLabelPortions => 'Portionen';

  @override
  String get guideLabelPortion => 'Portion';

  @override
  String get guideSampleDish => 'Basmatireis';

  @override
  String get guideSampleContainer => 'Blauer Behälter';

  @override
  String get guideSkip => 'Überspringen';

  @override
  String get guideNext => 'Weiter';

  @override
  String get guideStart => 'Los geht\'s';
}
