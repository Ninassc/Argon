import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

SpeedDialChild buttonSpeedChild({
  required IconData icone,
  required String label,
  required VoidCallback onTap,
}) {
  return SpeedDialChild(
    child: Icon(icone, color: Colors.white),
    label: label,
    onTap: onTap,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    backgroundColor: Color(0xFF5A81FA),
    labelBackgroundColor: Color.fromARGB(255, 168, 173, 187),
    labelStyle: TextStyle(color: Colors.white),
  );
}
