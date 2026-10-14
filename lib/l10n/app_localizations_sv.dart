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
  String get help_step1 => 'Börja med att ange namnet på maträtten';

  @override
  String get help_step2 => 'och direkt kan vi ange vikten på behållaren';

  @override
  String get help_step2_note => ', med locket om tillämpligt.';

  @override
  String get help_step3 => 'Om vi inte har allt klart än kan vi spara';

  @override
  String get help_step3_note => 'och fortsätta när vi har förberett maträtten.';

  @override
  String get help_step4 =>
      'När allt är klart, fyll behållaren och väg den, med locket om tillämpligt, och ange dess totalvikt';

  @override
  String get help_step5 => 'vi kommer att se att';

  @override
  String get help_step5_note => 'beräknas automatiskt och genom att ändra';

  @override
  String get help_step5_end => 'uppdateras det därefter.';

  @override
  String get help_step6 => 'Nu kan vi välja att ange antalet portioner';

  @override
  String get help_step6_note => 'eller vikten på en enskild portion';

  @override
  String get help_step6_end =>
      ', att ange en uppdaterar automatiskt den andra.';

  @override
  String get help_step7 => 'Vi kan nu spara allt med sparaknappen';

  @override
  String get help_gnam =>
      'När vi äter, istället för att ändra värdena manuellt kan vi använda Gnam-knappen';

  @override
  String get help_gnam_note =>
      'som tar bort en portion från behållaren och uppdaterar all data.';

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
  String get help_freshness =>
      'Bredvid namnet på varje rätt visar ett märke hur många dagar den har förvarats: grönt om den är färsk, orange om den bör ätas snart, rött om den har passerat hållbarheten som ställts in under Inställningar, olika för kylskåp och frys.';
}
