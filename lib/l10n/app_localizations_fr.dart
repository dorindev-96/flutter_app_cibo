// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get containerListPageTitle => 'Conteneurs dans le Réfrigérateur';

  @override
  String get containerDetailNewTitle => 'Nouveau Conteneur';

  @override
  String get containerDetailEditTitle => 'Modifier Conteneur';

  @override
  String get containerDetailNameLabel => 'Nom du Conteneur';

  @override
  String get containerDetailContainerWeightLabel => 'Poids du Conteneur (g)';

  @override
  String get containerDetailTotalWeightLabel => 'Poids Total (g)';

  @override
  String get containerDetailFoodWeightLabel => 'Poids de l\'Aliment (g)';

  @override
  String get containerDetailPortionLabel => 'Portion';

  @override
  String get containerDetailPortionWeightLabel => 'Poids de la Portion (g)';

  @override
  String get containerDetailSaveButton => 'Enregistrer Conteneur';

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
    return 'Date de Téléchargement: $date';
  }

  @override
  String get gen_No_Food => 'Tu n\'as rien à manger 😢';

  @override
  String gen_Gen_Error(String error) {
    return 'Erreur: $error';
  }

  @override
  String get gen_Confirm_Delete_Title => 'Confirmer la Suppression';

  @override
  String gen_Confirm_Delete_Message(String name) {
    return 'Voulez-vous supprimer \"$name\"?';
  }

  @override
  String get gen_Cancel => 'Annuler';

  @override
  String get gen_Delete => 'Supprimer';

  @override
  String get no_name => 'Sans Nom';

  @override
  String get settings_title => 'Paramètres';

  @override
  String get settings_theme => 'Thème';

  @override
  String get settings_help => 'Aide';

  @override
  String get help_title => 'Aide';

  @override
  String get help_intro => 'Voyons comment utiliser au mieux Cibo.';

  @override
  String get help_thanks => 'Merci d\'avoir téléchargé Cibo.';

  @override
  String get navTabFridge => 'Réfrigérateur';

  @override
  String get navTabContainers => 'Conteneurs';

  @override
  String get navTabSettings => 'Paramètres';

  @override
  String get containerSetsPageTitle => 'Sets de Conteneurs';

  @override
  String get containerSetsEmpty => 'Aucun set de conteneurs enregistré';

  @override
  String get containerSetsAddTitle => 'Ajouter un Set de Conteneur';

  @override
  String get containerSetsNameLabel => 'Nom';

  @override
  String get containerSetsWeightLabel => 'Poids (g)';

  @override
  String get containerSetsImageLabel => 'Image';

  @override
  String get containerSetsSaveButton => 'Enregistrer';

  @override
  String get containerSetsImageCamera => 'Appareil photo';

  @override
  String get containerSetsImageGallery => 'Galerie';

  @override
  String get containerSetsImageChoose => 'Choisir la Source d\'Image';

  @override
  String containerSetsWeight(String weight) {
    return 'Poids : $weight g';
  }

  @override
  String get presetPickerTitle => 'Sélectionner un Conteneur';

  @override
  String get presetPickerEmpty =>
      'Aucun conteneur préenregistré.\nAjoutez-les depuis l\'onglet Conteneurs.';

  @override
  String get settings_theme_system => 'Système';

  @override
  String get settings_theme_light => 'Clair';

  @override
  String get settings_theme_dark => 'Sombre';

  @override
  String get settings_freshness_fridge => 'Durée au réfrigérateur';

  @override
  String get settings_freshness_freezer => 'Durée au congélateur';

  @override
  String get settings_freshness_note =>
      'La pastille à côté de chaque plat devient orange lorsqu\'il faut le consommer bientôt et rouge lorsqu\'il dépasse la durée définie.';

  @override
  String get settings_freshness_days_label => 'Jours';

  @override
  String get gen_Save => 'Enregistrer';

  @override
  String freshnessDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days jours',
      one: '1 jour',
    );
    return '$_temp0';
  }

  @override
  String freshnessAge(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Il y a $days jours',
      one: 'Hier',
      zero: 'Aujourd\'hui',
    );
    return '$_temp0';
  }

  @override
  String get freshnessFresh => 'Frais';

  @override
  String get freshnessExpiring => 'À consommer bientôt';

  @override
  String get freshnessExpired => 'Périmé';

  @override
  String get containerDetailStorageLabel => 'Conservation';

  @override
  String get storageFridge => 'Réfrigérateur';

  @override
  String get storageFreezer => 'Congélateur';

  @override
  String get containerDetailDateLabel => 'Date de Téléchargement';

  @override
  String get guideWelcomeTitle => 'Bienvenue dans Cibo';

  @override
  String get guideWelcomeText =>
      'Vous cuisinez à l\'avance ? Cibo vous indique combien de portions il vous reste et combien de grammes prélever à chaque fois. Tout hors ligne, sur votre téléphone.';

  @override
  String get guideCalcTitle => 'Pesez, Cibo fait le reste';

  @override
  String get guideCalcText =>
      'Touchez + et pesez le conteneur vide puis plein : Cibo calcule le poids de la nourriture. Indiquez le nombre de portions ou le poids d\'une portion, l\'autre valeur se calcule toute seule.';

  @override
  String get guideGnamTitle => 'Gnam !';

  @override
  String get guideGnamText =>
      'Quand vous mangez une portion, touchez les couverts : les portions et le poids se mettent à jour tout seuls. Touchez le plat pour le modifier ou mettre à jour son poids total.';

  @override
  String get guideFreshTitle => 'Toujours frais';

  @override
  String get guideFreshText =>
      'La pastille indique depuis combien de jours le plat est conservé : verte s\'il est frais, orange s\'il faut le manger bientôt, rouge s\'il a dépassé sa durée. Choisissez réfrigérateur ou congélateur pour chaque plat ; les durées se modifient dans les Paramètres.';

  @override
  String get guideSetsTitle => 'Vos conteneurs';

  @override
  String get guideSetsText =>
      'Enregistrez les conteneurs que vous utilisez le plus, avec photo et poids, dans l\'onglet Conteneurs. En ajoutant un plat, touchez l\'icône du champ Poids du Conteneur pour ne pas avoir à le repeser.';

  @override
  String get guideLabelContainer => 'Conteneur';

  @override
  String get guideLabelFood => 'Nourriture';

  @override
  String get guideLabelTotal => 'Total';

  @override
  String get guideLabelPortions => 'Portions';

  @override
  String get guideLabelPortion => 'Portion';

  @override
  String get guideSampleDish => 'Riz basmati';

  @override
  String get guideSampleContainer => 'Conteneur bleu';

  @override
  String get guideSkip => 'Passer';

  @override
  String get guideNext => 'Suivant';

  @override
  String get guideStart => 'Commencer';
}
