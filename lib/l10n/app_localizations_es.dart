// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get containerListPageTitle => 'Contenedores en el Frigorífico';

  @override
  String get containerDetailNewTitle => 'Nuevo Contenedor';

  @override
  String get containerDetailEditTitle => 'Editar Contenedor';

  @override
  String get containerDetailNameLabel => 'Nombre del Contenedor';

  @override
  String get containerDetailContainerWeightLabel => 'Peso del Contenedor (g)';

  @override
  String get containerDetailTotalWeightLabel => 'Peso Total (g)';

  @override
  String get containerDetailFoodWeightLabel => 'Peso del Alimento (g)';

  @override
  String get containerDetailPortionLabel => 'Porción';

  @override
  String get containerDetailPortionWeightLabel => 'Peso de la Porción (g)';

  @override
  String get containerDetailSaveButton => 'Guardar Contenedor';

  @override
  String containerPortionWeight(String portion) {
    return 'Porción: $portion g';
  }

  @override
  String containerNrPortion(String nrPortion) {
    return 'N. Porciones: $nrPortion';
  }

  @override
  String containerUploadDate(String date) {
    return 'Fecha de Carga: $date';
  }

  @override
  String get gen_No_Food => 'No tienes nada que comer 😢';

  @override
  String gen_Gen_Error(String error) {
    return 'Error: $error';
  }

  @override
  String get gen_Confirm_Delete_Title => 'Confirmar Eliminación';

  @override
  String gen_Confirm_Delete_Message(String name) {
    return '¿Quieres eliminar \"$name\"?';
  }

  @override
  String get gen_Cancel => 'Cancelar';

  @override
  String get gen_Delete => 'Eliminar';

  @override
  String get no_name => 'Sin Nombre';

  @override
  String get settings_title => 'Configuración';

  @override
  String get settings_theme => 'Tema';

  @override
  String get settings_help => 'Ayuda';

  @override
  String get help_title => 'Ayuda';

  @override
  String get help_intro => 'Veamos cómo utilizar Cibo de la mejor manera.';

  @override
  String get help_thanks => 'Gracias por descargar Cibo.';

  @override
  String get navTabFridge => 'Nevera';

  @override
  String get navTabContainers => 'Contenedores';

  @override
  String get navTabSettings => 'Ajustes';

  @override
  String get containerSetsPageTitle => 'Sets de Contenedores';

  @override
  String get containerSetsEmpty => 'No hay sets de contenedores guardados';

  @override
  String get containerSetsAddTitle => 'Añadir Set de Contenedor';

  @override
  String get containerSetsNameLabel => 'Nombre';

  @override
  String get containerSetsWeightLabel => 'Peso (g)';

  @override
  String get containerSetsNameRequired => 'Introduce un nombre';

  @override
  String get containerSetsWeightInvalid => 'Introduce un peso mayor que 0';

  @override
  String get containerSetsImageLabel => 'Imagen';

  @override
  String get containerSetsSaveButton => 'Guardar';

  @override
  String get containerSetsImageCamera => 'Cámara';

  @override
  String get containerSetsImageGallery => 'Galería';

  @override
  String get containerSetsImageChoose => 'Elegir Fuente de Imagen';

  @override
  String containerSetsWeight(String weight) {
    return 'Peso: $weight g';
  }

  @override
  String get presetPickerTitle => 'Seleccionar un Contenedor';

  @override
  String get presetPickerEmpty =>
      'No hay contenedores preestablecidos.\nAñádelos desde la pestaña Contenedores.';

  @override
  String get settings_theme_system => 'Sistema';

  @override
  String get settings_theme_light => 'Claro';

  @override
  String get settings_theme_dark => 'Oscuro';

  @override
  String get settings_freshness_fridge => 'Duración en nevera';

  @override
  String get settings_freshness_freezer => 'Duración en congelador';

  @override
  String get settings_freshness_note =>
      'La etiqueta junto a cada plato se vuelve naranja cuando conviene consumirlo pronto y roja cuando supera la duración configurada.';

  @override
  String get settings_freshness_days_label => 'Días';

  @override
  String get gen_Save => 'Guardar';

  @override
  String freshnessDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days días',
      one: '1 día',
    );
    return '$_temp0';
  }

  @override
  String freshnessAge(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Hace $days días',
      one: 'Ayer',
      zero: 'Hoy',
    );
    return '$_temp0';
  }

  @override
  String get freshnessFresh => 'Fresco';

  @override
  String get freshnessExpiring => 'Consumir pronto';

  @override
  String get freshnessExpired => 'Caducado';

  @override
  String get containerDetailStorageLabel => 'Conservación';

  @override
  String get storageFridge => 'Nevera';

  @override
  String get storageFreezer => 'Congelador';

  @override
  String get containerDetailDateLabel => 'Fecha de Carga';

  @override
  String get guideWelcomeTitle => 'Te damos la bienvenida a Cibo';

  @override
  String get guideWelcomeText =>
      '¿Cocinas con antelación? Cibo te dice cuántas porciones tienes y cuántos gramos tomar cada vez. Todo sin conexión, en tu teléfono.';

  @override
  String get guideCalcTitle => 'Pésalo y Cibo hace el resto';

  @override
  String get guideCalcText =>
      'Toca + y pesa el contenedor vacío y luego lleno: Cibo calcula el peso de la comida. Introduce las porciones o el peso de una porción y el otro valor se calcula solo.';

  @override
  String get guideGnamTitle => '¡Gnam!';

  @override
  String get guideGnamText =>
      'Cuando comas una porción, toca los cubiertos: las porciones y el peso se actualizan solos. Toca el plato para editarlo o actualizar su peso total.';

  @override
  String get guideFreshTitle => 'Siempre fresco';

  @override
  String get guideFreshText =>
      'La etiqueta indica cuántos días lleva guardado el plato: verde si está fresco, naranja si conviene comerlo pronto, roja si ha superado su duración. Elige nevera o congelador para cada plato; las duraciones se cambian en Configuración.';

  @override
  String get guideSetsTitle => 'Tus contenedores';

  @override
  String get guideSetsText =>
      'Guarda los contenedores que más usas, con foto y peso, en la pestaña Contenedores. Al añadir un plato, toca el icono del campo Peso del Contenedor para no tener que pesarlo otra vez.';

  @override
  String get guideLabelContainer => 'Contenedor';

  @override
  String get guideLabelFood => 'Comida';

  @override
  String get guideLabelTotal => 'Total';

  @override
  String get guideLabelPortions => 'Porciones';

  @override
  String get guideLabelPortion => 'Porción';

  @override
  String get guideSampleDish => 'Arroz basmati';

  @override
  String get guideSampleContainer => 'Contenedor azul';

  @override
  String get guideSkip => 'Omitir';

  @override
  String get guideNext => 'Siguiente';

  @override
  String get guideStart => 'Empezar';
}
