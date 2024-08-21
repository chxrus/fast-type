import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _seedColor = Colors.greenAccent;
const _darkSurfaceColor = Colors.black;

final _textTheme = TextTheme(
  titleLarge: GoogleFonts.raleway(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  ),
  titleSmall: GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w300,
  ),
  displayLarge: GoogleFonts.raleway(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  ),
  labelLarge: GoogleFonts.roboto(
    fontSize: 18,
    color: _seedColor,
    fontWeight: FontWeight.w300,
  ),
  labelMedium: GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.normal,
  ),
  labelSmall: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
);

final darkTheme = ThemeData.from(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _seedColor,
    primary: _seedColor,
    surface: _darkSurfaceColor,
    brightness: Brightness.dark,
    error: Colors.red,
    errorContainer: Color.lerp(Colors.red, Colors.black, .8),
  ),
  textTheme: _textTheme,
);
