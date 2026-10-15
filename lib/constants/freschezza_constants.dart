/// Freshness-related constants
library;

/// Default number of days cooked food keeps in the fridge
const defaultGiorniFrigo = 3;

/// Default number of days food keeps in the freezer
const defaultGiorniFreezer = 90;

/// Minimum shelf life, in days, the user can set
const minGiorniFreschezza = 1;

/// Maximum shelf life, in days, the user can set
const maxGiorniFreschezza = 999;

/// Key for storing the fridge shelf life in shared preferences
const giorniFrigoKey = 'giorni_frigo';

/// Key for storing the freezer shelf life in shared preferences
const giorniFreezerKey = 'giorni_freezer';
