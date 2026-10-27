// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get containerListPageTitle => 'Containers in Fridge';

  @override
  String get containerDetailNewTitle => 'New Container';

  @override
  String get containerDetailEditTitle => 'Edit Container';

  @override
  String get containerDetailNameLabel => 'Container Name';

  @override
  String get containerDetailContainerWeightLabel => 'Container Weight (g)';

  @override
  String get containerDetailTotalWeightLabel => 'Total Weight (g)';

  @override
  String get containerDetailFoodWeightLabel => 'Food Weight (g)';

  @override
  String get containerDetailPortionLabel => 'Portion';

  @override
  String get containerDetailPortionWeightLabel => 'Portion Weight (g)';

  @override
  String get containerDetailSaveButton => 'Save Container';

  @override
  String containerPortionWeight(String portion) {
    return 'Portion: $portion g';
  }

  @override
  String containerNrPortion(String nrPortion) {
    return 'N. Portions: $nrPortion';
  }

  @override
  String containerUploadDate(String date) {
    return 'Upload Date: $date';
  }

  @override
  String get gen_No_Food => 'You have nothing to eat 😢';

  @override
  String gen_Gen_Error(String error) {
    return 'Error: $error';
  }

  @override
  String get gen_Confirm_Delete_Title => 'Confirm Deletion';

  @override
  String gen_Confirm_Delete_Message(String name) {
    return 'Do you want to delete \"$name\"?';
  }

  @override
  String get gen_Cancel => 'Cancel';

  @override
  String get gen_Delete => 'Delete';

  @override
  String get no_name => 'No Name';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_theme => 'Theme';

  @override
  String get settings_help => 'Help';

  @override
  String get help_title => 'Help';

  @override
  String get help_intro => 'Let\'s see how to make the best use of Cibo.';

  @override
  String get help_thanks => 'Thank you for downloading Cibo.';

  @override
  String get navTabFridge => 'Fridge';

  @override
  String get navTabContainers => 'Containers';

  @override
  String get navTabSettings => 'Settings';

  @override
  String get containerSetsPageTitle => 'Container Sets';

  @override
  String get containerSetsEmpty => 'No container sets saved yet';

  @override
  String get containerSetsAddTitle => 'Add Container Set';

  @override
  String get containerSetsNameLabel => 'Name';

  @override
  String get containerSetsWeightLabel => 'Weight (g)';

  @override
  String get containerSetsNameRequired => 'Enter a name';

  @override
  String get containerSetsWeightInvalid => 'Enter a weight greater than 0';

  @override
  String get containerSetsImageLabel => 'Image';

  @override
  String get containerSetsSaveButton => 'Save';

  @override
  String get containerSetsImageCamera => 'Camera';

  @override
  String get containerSetsImageGallery => 'Gallery';

  @override
  String get containerSetsImageChoose => 'Choose Image Source';

  @override
  String containerSetsWeight(String weight) {
    return 'Weight: $weight g';
  }

  @override
  String get presetPickerTitle => 'Select a Container';

  @override
  String get presetPickerEmpty =>
      'No container presets saved yet.\nAdd them from the Containers tab.';

  @override
  String get settings_theme_system => 'System';

  @override
  String get settings_theme_light => 'Light';

  @override
  String get settings_theme_dark => 'Dark';

  @override
  String get settings_freshness_fridge => 'Fridge shelf life';

  @override
  String get settings_freshness_freezer => 'Freezer shelf life';

  @override
  String get settings_freshness_note =>
      'The badge next to each dish turns orange when it should be eaten soon and red once it is past the shelf life you set.';

  @override
  String get settings_freshness_days_label => 'Days';

  @override
  String get gen_Save => 'Save';

  @override
  String freshnessDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String freshnessAge(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days ago',
      one: 'Yesterday',
      zero: 'Today',
    );
    return '$_temp0';
  }

  @override
  String get freshnessFresh => 'Fresh';

  @override
  String get freshnessExpiring => 'Eat soon';

  @override
  String get freshnessExpired => 'Expired';

  @override
  String get containerDetailStorageLabel => 'Storage';

  @override
  String get storageFridge => 'Fridge';

  @override
  String get storageFreezer => 'Freezer';

  @override
  String get containerDetailDateLabel => 'Upload Date';

  @override
  String get guideWelcomeTitle => 'Welcome to Cibo';

  @override
  String get guideWelcomeText =>
      'Cooking ahead? Cibo tells you how many portions you have and how many grams to take each time. All offline, on your phone.';

  @override
  String get guideCalcTitle => 'Weigh it, Cibo does the rest';

  @override
  String get guideCalcText =>
      'Tap + and weigh the container empty and then full: Cibo works out the weight of the food. Enter the portions or the weight of one portion and the other value is calculated for you.';

  @override
  String get guideGnamTitle => 'Gnam!';

  @override
  String get guideGnamText =>
      'When you eat a portion, tap the cutlery: portions and weight update by themselves. Tap the dish to edit it or update its total weight.';

  @override
  String get guideFreshTitle => 'Always fresh';

  @override
  String get guideFreshText =>
      'The badge shows how many days the dish has been stored: green when it is fresh, orange when it should be eaten soon, red once it is past its shelf life. Choose fridge or freezer for each dish; you can change the shelf life in Settings.';

  @override
  String get guideSetsTitle => 'Your containers';

  @override
  String get guideSetsText =>
      'Save the containers you use most, with photo and weight, in the Containers tab. When adding a dish, tap the icon in the Container Weight field so you don\'t have to weigh it again.';

  @override
  String get guideLabelContainer => 'Container';

  @override
  String get guideLabelFood => 'Food';

  @override
  String get guideLabelTotal => 'Total';

  @override
  String get guideLabelPortions => 'Portions';

  @override
  String get guideLabelPortion => 'Portion';

  @override
  String get guideSampleDish => 'Basmati rice';

  @override
  String get guideSampleContainer => 'Blue container';

  @override
  String get guideSkip => 'Skip';

  @override
  String get guideNext => 'Next';

  @override
  String get guideStart => 'Get started';
}
