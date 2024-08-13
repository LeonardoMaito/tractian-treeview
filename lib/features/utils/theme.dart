import 'package:flutter/material.dart';

class CustomTheme{
  static ThemeData customTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(color: Color(0xFF17192d)),
    scaffoldBackgroundColor: Colors.white,
    textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionHandleColor: Colors.black),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll<Size>(Size(150, 75)),
          backgroundColor: const WidgetStatePropertyAll<Color>(
              Color(0xFF2188ff)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: Colors.white,
      color: Color(0xFF17192d)

    )
  );
}