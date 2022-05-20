import 'package:natural_20/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const LoginScreen(),
      duration: 5000,
      imageSize: 500,
      imageSrc: "assets/logo.png",
      textType: TextType.ScaleAnimatedText,
    );
  }
}