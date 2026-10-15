// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get containerListPageTitle => 'Behållare i kylen';

  @override
  String get containerDetailNewTitle => 'Ny behållare';

  @override
  String get containerDetailEditTitle => 'Redigera behållare';

  @override
  String get containerDetailNameLabel => 'Behållarens namn';

  @override
  String get containerDetailContainerWeightLabel => 'Behållarens vikt (g)';

  @override
  String get containerDetailTotalWeightLabel => 'Total vikt (g)';

  @override
  String get containerDetailFoodWeightLabel => 'Matens vikt (g)';

  @override
  String get containerDetailPortionLabel => 'Portion';

  @override
  String get containerDetailPortionWeightLabel => 'Portionsvikt (g)';

  @override
  String get containerDetailSaveButton => 'Spara behållare';

  @override
  String containerPortionWeight(String portion) {
    return 'Portion: $portion g';
  }

  @override
  String containerNrPortion(String nrPortion) {
    return 'Antal portioner: $nrPortion';
  }

  @override
  String containerUploadDate(String date) {
    return 'Uppladdningsdatum: $date';
  }

  @override
  String get gen_No_Food => 'Du har ingenting att äta 😢';

  @override
  String gen_Gen_Error(String error) {
    return 'Fel: $error';
  }

  @override
  String get gen_Confirm_Delete_Title => 'Bekräfta borttagning';

  @override
  String gen_Confirm_Delete_Message(String name) {
    return 'Vill du ta bort \"$name\"?';
  }

  @override
  String get gen_Cancel => 'Avbryt';

  @override
  String get gen_Delete => 'Ta bort';

  @override
  String get no_name => 'Utan namn';

  @override
  String get settings_title => 'Inställningar';

  @override
  String get settings_theme => 'Tema';

  @override
  String get settings_help => 'Hjälp';

  @override
  String get help_title => 'Hjälp';

  @override
  String get help_intro => 'Låt oss se hur man använder Cibo på bästa sätt.';

  @override
  String get help_thanks => 'Tack för att du laddade ner Cibo.';

  @override
  String get navTabFridge => 'Kylskåp';

  @override
  String get navTabContainers => 'Behållare';

  @override
  String get navTabSettings => 'Inställningar';

  @override
  String get containerSetsPageTitle => 'Behållar-set';

  @override
  String get containerSetsEmpty => 'Inga behållar-set sparade ännu';

  @override
  String get containerSetsAddTitle => 'Lägg till behållar-set';

  @override
  String get containerSetsNameLabel => 'Namn';

  @override
  String get containerSetsWeightLabel => 'Vikt (g)';

  @override
  String get containerSetsImageLabel => 'Bild';

  @override
  String get containerSetsSaveButton => 'Spara';

  @override
  String get containerSetsImageCamera => 'Kamera';

  @override
  String get containerSetsImageGallery => 'Galleri';

  @override
  String get containerSetsImageChoose => 'Välj bildkälla';

  @override
  String containerSetsWeight(String weight) {
    return 'Vikt: $weight g';
  }

  @override
  String get presetPickerTitle => 'Välj en behållare';

  @override
  String get presetPickerEmpty =>
      'Inga förinställda behållare sparade.\nLägg till dem från fliken Behållare.';

  @override
  String get settings_theme_system => 'System';

  @override
  String get settings_theme_light => 'Ljust';

  @override
  String get settings_theme_dark => 'Mörkt';

  @override
  String get settings_freshness_fridge => 'Hållbarhet i kylskåp';

  @override
  String get settings_freshness_freezer => 'Hållbarhet i frys';

  @override
  String get settings_freshness_note =>
      'Märket bredvid varje rätt blir orange när den bör ätas snart och rött när den har passerat den inställda hållbarheten.';

  @override
  String get settings_freshness_days_label => 'Dagar';

  @override
  String get gen_Save => 'Spara';

  @override
  String freshnessDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dagar',
      one: '1 dag',
    );
    return '$_temp0';
  }

  @override
  String freshnessAge(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'För $days dagar sedan',
      one: 'Igår',
      zero: 'Idag',
    );
    return '$_temp0';
  }

  @override
  String get freshnessFresh => 'Färsk';

  @override
  String get freshnessExpiring => 'Ät snart';

  @override
  String get freshnessExpired => 'Utgången';

  @override
  String get containerDetailStorageLabel => 'Förvaring';

  @override
  String get storageFridge => 'Kylskåp';

  @override
  String get storageFreezer => 'Frys';

  @override
  String get containerDetailDateLabel => 'Uppladdningsdatum';

  @override
  String get guideWelcomeTitle => 'Välkommen till Cibo';

  @override
  String get guideWelcomeText =>
      'Lagar du mat i förväg? Cibo berättar hur många portioner du har och hur många gram du ska ta varje gång. Allt offline, i din telefon.';

  @override
  String get guideCalcTitle => 'Väg, Cibo sköter resten';

  @override
  String get guideCalcText =>
      'Tryck på + och väg behållaren tom och sedan full: Cibo räknar ut matens vikt. Ange antalet portioner eller vikten på en portion, så räknas det andra värdet ut automatiskt.';

  @override
  String get guideGnamTitle => 'Gnam!';

  @override
  String get guideGnamText =>
      'När du äter en portion trycker du på besticken: portioner och vikt uppdateras automatiskt. Tryck på rätten för att redigera den eller uppdatera totalvikten.';

  @override
  String get guideFreshTitle => 'Alltid färskt';

  @override
  String get guideFreshText =>
      'Märket visar hur många dagar rätten har förvarats: grönt om den är färsk, orange om den bör ätas snart, rött om den har passerat hållbarheten. Välj kylskåp eller frys för varje rätt; hållbarheten ändrar du under Inställningar.';

  @override
  String get guideSetsTitle => 'Dina behållare';

  @override
  String get guideSetsText =>
      'Spara de behållare du använder mest, med foto och vikt, under fliken Behållare. När du lägger till en rätt trycker du på ikonen i fältet Behållarens vikt så slipper du väga den igen.';

  @override
  String get guideLabelContainer => 'Behållare';

  @override
  String get guideLabelFood => 'Mat';

  @override
  String get guideLabelTotal => 'Totalt';

  @override
  String get guideLabelPortions => 'Portioner';

  @override
  String get guideLabelPortion => 'Portion';

  @override
  String get guideSampleDish => 'Basmatiris';

  @override
  String get guideSampleContainer => 'Blå behållare';

  @override
  String get guideSkip => 'Hoppa över';

  @override
  String get guideNext => 'Nästa';

  @override
  String get guideStart => 'Kom igång';
}
