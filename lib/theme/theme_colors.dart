/// Color definitions for light and dark themes
///
/// Uses a warm, food-inspired palette: teal primary with amber accents.
library;

import 'package:flutter/material.dart';

/// Light theme color palette
abstract final class LightColors {
  /// Primary brand color – warm teal
  static const Color primary = Color(0xFF00897B);

  /// Color for content on primary
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Primary container color
  static const Color primaryContainer = Color(0xFFB2DFDB);

  /// Color for content on primary container
  static const Color onPrimaryContainer = Color(0xFF004D40);

  /// Secondary brand color – amber accent
  static const Color secondary = Color(0xFFFFB300);

  /// Color for content on secondary
  static const Color onSecondary = Color(0xFF3E2723);

  /// Secondary container color
  static const Color secondaryContainer = Color(0xFFFFECB3);

  /// Color for content on secondary container
  static const Color onSecondaryContainer = Color(0xFF5D4037);

  /// Tertiary accent color
  static const Color tertiary = Color(0xFF8D6E63);

  /// Color for content on tertiary
  static const Color onTertiary = Color(0xFFFFFFFF);

  /// Background color
  static const Color background = Color(0xFFF9F6F2);

  /// Surface color
  static const Color surface = Color(0xFFFFFFFF);

  /// Color for content on surface
  static const Color onSurface = Color(0xFF1C1B1F);

  /// Surface-variant for subtle differentiation
  static const Color surfaceContainerHighest = Color(0xFFF0EDE8);

  /// Outline color
  static const Color outline = Color(0xFFBDBDBD);

  /// Error color
  static const Color error = Color(0xFFB3261E);

  /// Color for content on error
  static const Color onError = Color(0xFFFFFFFF);

  /// Freshness badge color for fresh food
  static const Color fresh = Color(0xFF2E7D32);

  /// Freshness badge color for food to be eaten soon
  static const Color expiring = Color(0xFFB45309);
}

/// Dark theme color palette
abstract final class DarkColors {
  /// Primary brand color – soft teal
  static const Color primary = Color(0xFF80CBC4);

  /// Color for content on primary
  static const Color onPrimary = Color(0xFF003731);

  /// Primary container color
  static const Color primaryContainer = Color(0xFF00695C);

  /// Color for content on primary container
  static const Color onPrimaryContainer = Color(0xFFB2DFDB);

  /// Secondary brand color – golden amber
  static const Color secondary = Color(0xFFFFD54F);

  /// Color for content on secondary
  static const Color onSecondary = Color(0xFF3E2723);

  /// Secondary container color
  static const Color secondaryContainer = Color(0xFF795548);

  /// Color for content on secondary container
  static const Color onSecondaryContainer = Color(0xFFFFECB3);

  /// Tertiary accent color
  static const Color tertiary = Color(0xFFBCAAA4);

  /// Color for content on tertiary
  static const Color onTertiary = Color(0xFF3E2723);

  /// Background color
  static const Color background = Color(0xFF1A1A1A);

  /// Surface color
  static const Color surface = Color(0xFF242424);

  /// Color for content on surface
  static const Color onSurface = Color(0xFFE6E1E5);

  /// Surface-variant for subtle differentiation
  static const Color surfaceContainerHighest = Color(0xFF2E2E2E);

  /// Outline color
  static const Color outline = Color(0xFF616161);

  /// Error color
  static const Color error = Color(0xFFF2B8B5);

  /// Color for content on error
  static const Color onError = Color(0xFF601410);

  /// Freshness badge color for fresh food
  static const Color fresh = Color(0xFF81C784);

  /// Freshness badge color for food to be eaten soon
  static const Color expiring = Color(0xFFFBBF24);
}
