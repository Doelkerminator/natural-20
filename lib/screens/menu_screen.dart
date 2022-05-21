import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Auth/AuthenticatorFacebook.dart';
import '../Auth/AuthenticatorGoogle.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({ Key? key }) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser?.displayName);
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      /*child: TextButton(
                onPressed: () async { 
                  if(FirebaseAuth.instance.currentUser?.providerData[0].providerId == "google.com") { await AuthenticatorGoogle.closeSession(); } 
                  else if(FirebaseAuth.instance.currentUser?.providerData[0].providerId == "facebook.com") { await AuthenticatorFacebook.closeSession(); }
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                }, 
                child: const Text("Cerrar")
              ),*/
    );
  }
}