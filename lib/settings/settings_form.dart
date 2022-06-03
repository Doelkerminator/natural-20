import 'package:flutter/material.dart';
import 'package:natural_20/settings/settings_color.dart';

class SettingsForm {
  static InputDecoration textFieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: SettingsColor.textColor
      ),
      fillColor: Colors.transparent,
      border: const OutlineInputBorder()
    );
  }
}