import 'package:flutter/material.dart';

ThemeData temaArgon(Brightness brilho) {
  const azulArgon = Color(0xFF5A81FA);
  final cores = ColorScheme.fromSeed(
    seedColor: azulArgon,
    brightness: brilho,
    primary: brilho == Brightness.light ? azulArgon : null,
    surface: brilho == Brightness.light
        ? Colors.white
        : const Color(0xFF14151C),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: cores,
    scaffoldBackgroundColor: cores.surface,
    appBarTheme: AppBarTheme(backgroundColor: cores.surface),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: cores.inverseSurface,
      contentTextStyle: TextStyle(
        color: cores.onInverseSurface,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
    ),
  );
}

extension CoresDoTema on BuildContext {
  ColorScheme get cores => Theme.of(this).colorScheme;
}
