import 'package:flutter/material.dart';
import 'package:natural_20/settings/settings_color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0,),
        child: null,
      ),
      backgroundColor: SettingsColor.primaryColor
    );
  }
}