import 'package:flutter/material.dart';
import 'package:natural_20/providers/add_campaign_notifier.dart';
import 'package:natural_20/providers/add_note_notifier.dart';
import 'package:natural_20/providers/login_notifier.dart';
import 'package:natural_20/routes/routes.dart';
import 'package:natural_20/screens/screen_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=> LoginState()),
      ChangeNotifierProvider(create: (_)=> AddCampaignState()),
      ChangeNotifierProvider(create: (_)=> AddNoteState())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: getApplicationRoutes(),
      theme: ThemeData(fontFamily: "Schyler"),
      home: const SplashScreen()
    );
  }
}