import 'package:flutter/material.dart';
import 'package:natural_20/routes/routes.dart';
import 'package:natural_20/screens/screen_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: getApplicationRoutes(),
        home: const SplashScreen()
    );
  }
}