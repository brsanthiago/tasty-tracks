import 'package:flutter/material.dart';

ThemeData _buildTastyTracksTheme() {
  final Color primaryColor = Colors.blueGrey[900];
  final Color secondaryColor = Colors.greenAccent[100];
  final ColorScheme colorScheme = ColorScheme.dark().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
    primaryColor: primaryColor,
    buttonColor: primaryColor,
    dividerColor: Colors.white.withOpacity(0.6),
    cardColor: Colors.blueGrey[900],
    accentColor: secondaryColor,
    canvasColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    backgroundColor: Colors.black,
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  return base.copyWith(
    // Disabled slider is invisible on black background
    sliderTheme: base.sliderTheme.copyWith(
      disabledThumbColor: Colors.white70,
      disabledActiveTrackColor: Colors.white54,
      disabledInactiveTrackColor: Colors.white30,
    ),
  );
}

final ThemeData tastyTracksTheme = _buildTastyTracksTheme();
