import 'package:flutter/material.dart';
import 'package:natural_20/settings/settings_color.dart';

class SettingsButtons {
  static ButtonStyle buttonStyle1() {
    return ButtonStyle(
      elevation: MaterialStateProperty.all(1),
      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
      backgroundColor: MaterialStateProperty.all(SettingsColor.secondaryColor),
      textStyle:  MaterialStateProperty.all(TextStyle(
        color: SettingsColor.textColor,
        fontFamily: "Serpentine",
        fontSize: 15
      )),
    );
  }
}