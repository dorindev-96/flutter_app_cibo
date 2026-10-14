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
  String get help_step1 => 'Empezamos introduciendo el nombre del plato';

  @override
  String get help_step2 =>
      'e inmediatamente podemos introducir el peso del contenedor';

  @override
  String get help_step2_note => ', con la tapa si corresponde.';

  @override
  String get help_step3 =>
      'En este punto, si aún no tenemos todo listo, podemos guardar';

  @override
  String get help_step3_note =>
      'y continuar una vez que hayamos preparado el plato.';

  @override
  String get help_step4 =>
      'Una vez que todo esté listo, llenamos el contenedor y lo pesamos, con la tapa si corresponde, e introducimos su peso total';

  @override
  String get help_step5 => 'veremos que';

  @override
  String get help_step5_note => 'se calcula automáticamente y al cambiar';

  @override
  String get help_step5_end => 'se actualizará en consecuencia.';

  @override
  String get help_step6 =>
      'En este punto podemos elegir introducir el número de porciones';

  @override
  String get help_step6_note => 'o el peso de una sola porción';

  @override
  String get help_step6_end =>
      ', al introducir una, la otra se actualizará automáticamente.';

  @override
  String get help_step7 => 'Ahora podemos guardar todo usando el botón guardar';

  @override
  String get help_gnam =>
      'Cuando comemos, en lugar de cambiar los valores manualmente podemos usar el botón Gnam';

  @override
  String get help_gnam_note =>
      'que eliminará una porción del contenedor y actualizará todos los datos.';

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
  String get help_freshness =>
      'Junto al nombre de cada plato, una etiqueta indica cuántos días lleva guardado: verde si está fresco, naranja si conviene consumirlo pronto, roja si ha superado la duración configurada en Configuración, distinta para nevera y congelador.';
}
