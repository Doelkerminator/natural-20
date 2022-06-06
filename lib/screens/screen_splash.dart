import 'package:firebase_auth/firebase_auth.dart';
import 'package:natural_20/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:natural_20/screens/menu_screen.dart';
import 'package:natural_20/settings/settings_color.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      backgroundColor: SettingsColor.primaryColor,
      navigateRoute: FirebaseAuth.instance.currentUser != null ? const MenuScreen() : const LoginScreen(),
      duration: 5000,
      imageSize: 500,
      imageSrc: "assets/images/logo.png",
      textType: TextType.ScaleAnimatedText,
    );
  }
}