import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

SpeedDialChild buttonSpeedChild(
  BuildContext context, {
  required IconData icone,
  required String label,
  required VoidCallback onTap,
}) {
  final cores = Theme.of(context).colorScheme;
  return SpeedDialChild(
    child: Icon(icone, color: cores.onPrimary),
    label: label,
    onTap: onTap,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    backgroundColor: cores.primary,
    labelBackgroundColor: cores.inverseSurface,
    labelStyle: TextStyle(color: cores.onInverseSurface),
  );
}
