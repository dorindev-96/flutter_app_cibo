import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_sv.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('de'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('sv'),
  ];

  /// The title for the container list page
  ///
  /// In it, this message translates to:
  /// **'Contenitori in Frigo'**
  String get containerListPageTitle;

  /// The title for the new container detail page
  ///
  /// In it, this message translates to:
  /// **'Nuovo Contenitore'**
  String get containerDetailNewTitle;

  /// The title for the edit container detail page
  ///
  /// In it, this message translates to:
  /// **'Modifica Contenitore'**
  String get containerDetailEditTitle;

  /// Label for the container name field in the container detail page
  ///
  /// In it, this message translates to:
  /// **'Nome Contenitore'**
  String get containerDetailNameLabel;

  /// Label for the container weight field in the container detail page
  ///
  /// In it, this message translates to:
  /// **'Peso Contenitore (g)'**
  String get containerDetailContainerWeightLabel;

  /// Label for the total weight field (container + food) in the container detail page
  ///
  /// In it, this message translates to:
  /// **'Peso Totale (g)'**
  String get containerDetailTotalWeightLabel;

  /// Label for the food weight field in the container detail page
  ///
  /// In it, this message translates to:
  /// **'Peso Cibo (g)'**
  String get containerDetailFoodWeightLabel;

  /// Label for the portion field in the container detail page
  ///
  /// In it, this message translates to:
  /// **'Porzione'**
  String get containerDetailPortionLabel;

  /// Label for the portion weight field in the container detail page
  ///
  /// In it, this message translates to:
  /// **'Peso Porzione (g)'**
  String get containerDetailPortionWeightLabel;

  /// Label for the save container button in the container detail page
  ///
  /// In it, this message translates to:
  /// **'Salva Contenitore'**
  String get containerDetailSaveButton;

  /// Label showing the portion weight
  ///
  /// In it, this message translates to:
  /// **'Porzione: {portion} g'**
  String containerPortionWeight(String portion);

  /// Label showing the number of portions
  ///
  /// In it, this message translates to:
  /// **'N. Porzioni: {nrPortion}'**
  String containerNrPortion(String nrPortion);

  /// Label showing the upload date of the container
  ///
  /// In it, this message translates to:
  /// **'Data Caricamento: {date}'**
  String containerUploadDate(String date);

  /// Message displayed when there is no food in the fridge
  ///
  /// In it, this message translates to:
  /// **'Non hai nulla da mangiare 😢'**
  String get gen_No_Food;

  /// Generic error message with error details
  ///
  /// In it, this message translates to:
  /// **'Errore: {error}'**
  String gen_Gen_Error(String error);

  /// Title for the delete confirmation dialog
  ///
  /// In it, this message translates to:
  /// **'Conferma Eliminazione'**
  String get gen_Confirm_Delete_Title;

  /// Message for the delete confirmation dialog
  ///
  /// In it, this message translates to:
  /// **'Vuoi eliminare \"{name}\"?'**
  String gen_Confirm_Delete_Message(String name);

  /// Cancel button label
  ///
  /// In it, this message translates to:
  /// **'Annulla'**
  String get gen_Cancel;

  /// Delete button label
  ///
  /// In it, this message translates to:
  /// **'Elimina'**
  String get gen_Delete;

  /// Placeholder for items without a name
  ///
  /// In it, this message translates to:
  /// **'Senza Nome'**
  String get no_name;

  /// Title for the settings screen
  ///
  /// In it, this message translates to:
  /// **'Impostazioni'**
  String get settings_title;

  /// Label for the theme setting in the settings screen
  ///
  /// In it, this message translates to:
  /// **'Tema'**
  String get settings_theme;

  /// Label for the help option in the settings screen
  ///
  /// In it, this message translates to:
  /// **'Aiuto'**
  String get settings_help;

  /// Title for the help screen
  ///
  /// In it, this message translates to:
  /// **'Aiuto'**
  String get help_title;

  /// Introduction text for the help screen
  ///
  /// In it, this message translates to:
  /// **'Vediamo come utilizzare al meglio Cibo.'**
  String get help_intro;

  /// Thank you message
  ///
  /// In it, this message translates to:
  /// **'Grazie per aver scaricato Cibo.'**
  String get help_thanks;

  /// Label for the Fridge tab in the bottom navigation bar
  ///
  /// In it, this message translates to:
  /// **'Frigo'**
  String get navTabFridge;

  /// Label for the Containers tab in the bottom navigation bar
  ///
  /// In it, this message translates to:
  /// **'Contenitori'**
  String get navTabContainers;

  /// Label for the Settings tab in the bottom navigation bar
  ///
  /// In it, this message translates to:
  /// **'Impostazioni'**
  String get navTabSettings;

  /// Title for the container sets list page
  ///
  /// In it, this message translates to:
  /// **'Set Contenitori'**
  String get containerSetsPageTitle;

  /// Message displayed when there are no saved container sets
  ///
  /// In it, this message translates to:
  /// **'Nessun set di contenitori salvato'**
  String get containerSetsEmpty;

  /// Title for the add container set form
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Set Contenitore'**
  String get containerSetsAddTitle;

  /// Label for the container set name field
  ///
  /// In it, this message translates to:
  /// **'Nome'**
  String get containerSetsNameLabel;

  /// Label for the container set weight field
  ///
  /// In it, this message translates to:
  /// **'Peso (g)'**
  String get containerSetsWeightLabel;

  /// Label for the container set image field
  ///
  /// In it, this message translates to:
  /// **'Immagine'**
  String get containerSetsImageLabel;

  /// Label for the save button in the add container set form
  ///
  /// In it, this message translates to:
  /// **'Salva'**
  String get containerSetsSaveButton;

  /// Label for the camera option in the image source picker
  ///
  /// In it, this message translates to:
  /// **'Fotocamera'**
  String get containerSetsImageCamera;

  /// Label for the gallery option in the image source picker
  ///
  /// In it, this message translates to:
  /// **'Galleria'**
  String get containerSetsImageGallery;

  /// Title for the image source selection dialog
  ///
  /// In it, this message translates to:
  /// **'Scegli Origine Immagine'**
  String get containerSetsImageChoose;

  /// Label showing the container set weight
  ///
  /// In it, this message translates to:
  /// **'Peso: {weight} g'**
  String containerSetsWeight(String weight);

  /// Title for the container preset picker dialog
  ///
  /// In it, this message translates to:
  /// **'Seleziona un Contenitore'**
  String get presetPickerTitle;

  /// Message when no presets are available in the picker
  ///
  /// In it, this message translates to:
  /// **'Nessun contenitore preimpostato.\nAggiungili dalla scheda Contenitori.'**
  String get presetPickerEmpty;

  /// Theme option that follows the system setting
  ///
  /// In it, this message translates to:
  /// **'Sistema'**
  String get settings_theme_system;

  /// Theme option for the light theme
  ///
  /// In it, this message translates to:
  /// **'Chiaro'**
  String get settings_theme_light;

  /// Theme option for the dark theme
  ///
  /// In it, this message translates to:
  /// **'Scuro'**
  String get settings_theme_dark;

  /// Label for the setting of how many days food keeps in the fridge
  ///
  /// In it, this message translates to:
  /// **'Durata in frigo'**
  String get settings_freshness_fridge;

  /// Label for the setting of how many days food keeps in the freezer
  ///
  /// In it, this message translates to:
  /// **'Durata in freezer'**
  String get settings_freshness_freezer;

  /// Explanation of the freshness badge shown below the freshness settings
  ///
  /// In it, this message translates to:
  /// **'Il bollino accanto a ogni pietanza diventa arancione quando va consumata presto e rosso quando supera la durata impostata.'**
  String get settings_freshness_note;

  /// Label for the number of days field in the shelf life dialog
  ///
  /// In it, this message translates to:
  /// **'Giorni'**
  String get settings_freshness_days_label;

  /// Save button label
  ///
  /// In it, this message translates to:
  /// **'Salva'**
  String get gen_Save;

  /// Number of days of shelf life
  ///
  /// In it, this message translates to:
  /// **'{days, plural, =1{1 giorno} other{{days} giorni}}'**
  String freshnessDays(int days);

  /// How long ago the food was stored, shown in the freshness badge
  ///
  /// In it, this message translates to:
  /// **'{days, plural, =0{Oggi} =1{Ieri} other{{days} giorni fa}}'**
  String freshnessAge(int days);

  /// Freshness status: the food is fresh
  ///
  /// In it, this message translates to:
  /// **'Fresco'**
  String get freshnessFresh;

  /// Freshness status: the food should be eaten soon
  ///
  /// In it, this message translates to:
  /// **'Da consumare presto'**
  String get freshnessExpiring;

  /// Freshness status: the food is past its shelf life
  ///
  /// In it, this message translates to:
  /// **'Scaduto'**
  String get freshnessExpired;

  /// Label for the storage (fridge or freezer) selector in the container detail page
  ///
  /// In it, this message translates to:
  /// **'Conservazione'**
  String get containerDetailStorageLabel;

  /// Storage option: fridge
  ///
  /// In it, this message translates to:
  /// **'Frigo'**
  String get storageFridge;

  /// Storage option: freezer
  ///
  /// In it, this message translates to:
  /// **'Freezer'**
  String get storageFreezer;

  /// Label for the upload date field in the container detail page
  ///
  /// In it, this message translates to:
  /// **'Data Caricamento'**
  String get containerDetailDateLabel;

  /// Title of the welcome page of the introductory guide
  ///
  /// In it, this message translates to:
  /// **'Ti diamo il benvenuto in Cibo'**
  String get guideWelcomeTitle;

  /// Text of the welcome page of the introductory guide
  ///
  /// In it, this message translates to:
  /// **'Cucini in anticipo? Cibo ti dice quante porzioni hai e quanti grammi prelevare ogni volta. Tutto offline, sul tuo telefono.'**
  String get guideWelcomeText;

  /// Title of the guide section explaining the automatic weight calculation
  ///
  /// In it, this message translates to:
  /// **'Pesa, al resto pensa Cibo'**
  String get guideCalcTitle;

  /// Text of the guide section explaining the automatic weight calculation
  ///
  /// In it, this message translates to:
  /// **'Tocca + e pesa il contenitore vuoto e poi pieno: Cibo calcola il peso del cibo. Inserisci le porzioni o il peso di una porzione e l\'altro valore si calcola da solo.'**
  String get guideCalcText;

  /// Title of the guide section explaining the Gnam button
  ///
  /// In it, this message translates to:
  /// **'Gnam!'**
  String get guideGnamTitle;

  /// Text of the guide section explaining the Gnam button
  ///
  /// In it, this message translates to:
  /// **'Quando mangi una porzione tocca le posate: porzioni e peso si aggiornano da soli. Tocca il piatto per modificarlo o aggiornare il peso totale.'**
  String get guideGnamText;

  /// Title of the guide section explaining the freshness badge
  ///
  /// In it, this message translates to:
  /// **'Sempre fresco'**
  String get guideFreshTitle;

  /// Text of the guide section explaining the freshness badge
  ///
  /// In it, this message translates to:
  /// **'Il bollino mostra da quanti giorni il piatto è conservato: verde se è fresco, arancione se va mangiato presto, rosso se ha superato la durata. Per ogni piatto scegli frigo o freezer; le durate si cambiano nelle Impostazioni.'**
  String get guideFreshText;

  /// Title of the guide section explaining the saved containers
  ///
  /// In it, this message translates to:
  /// **'I tuoi contenitori'**
  String get guideSetsTitle;

  /// Text of the guide section explaining the saved containers
  ///
  /// In it, this message translates to:
  /// **'Salva nella scheda Contenitori quelli che usi più spesso, con foto e peso. Quando aggiungi un piatto, tocca l\'icona nel campo Peso Contenitore per non doverlo ripesare.'**
  String get guideSetsText;

  /// Short label for the container weight in the guide calculation example
  ///
  /// In it, this message translates to:
  /// **'Contenitore'**
  String get guideLabelContainer;

  /// Short label for the food weight in the guide calculation example
  ///
  /// In it, this message translates to:
  /// **'Cibo'**
  String get guideLabelFood;

  /// Short label for the total weight in the guide calculation example
  ///
  /// In it, this message translates to:
  /// **'Totale'**
  String get guideLabelTotal;

  /// Short label for the number of portions in the guide calculation example
  ///
  /// In it, this message translates to:
  /// **'Porzioni'**
  String get guideLabelPortions;

  /// Short label for the weight of a portion in the guide calculation example
  ///
  /// In it, this message translates to:
  /// **'Porzione'**
  String get guideLabelPortion;

  /// Name of the sample dish shown in the guide
  ///
  /// In it, this message translates to:
  /// **'Riso basmati'**
  String get guideSampleDish;

  /// Name of the sample container shown in the guide
  ///
  /// In it, this message translates to:
  /// **'Contenitore blu'**
  String get guideSampleContainer;

  /// Button to skip the introductory guide
  ///
  /// In it, this message translates to:
  /// **'Salta'**
  String get guideSkip;

  /// Button to go to the next page of the introductory guide
  ///
  /// In it, this message translates to:
  /// **'Avanti'**
  String get guideNext;

  /// Button to close the introductory guide on its last page
  ///
  /// In it, this message translates to:
  /// **'Inizia'**
  String get guideStart;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'sv',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'sv':
      return AppLocalizationsSv();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
