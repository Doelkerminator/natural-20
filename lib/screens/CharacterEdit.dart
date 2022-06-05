import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:natural_20/settings/settings_color.dart';
import 'package:natural_20/views/CharacterForm.dart';

class CharacterEditScreen extends StatefulWidget {
  const CharacterEditScreen({Key? key}) : super(key: key);

  @override
  State<CharacterEditScreen> createState() => _CharacterEditState();
}

class _CharacterEditState extends State<CharacterEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SettingsColor.primaryColor,
      body: CharacterForm()
    );
  }
}