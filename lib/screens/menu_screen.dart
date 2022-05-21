import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natural_20/settings/settings_color.dart';

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
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Menú Principal')),
        drawer: Container(
          width: MediaQuery.of(context).size.width / 1.6,
          child: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: SettingsColor.secondaryColor,
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage("${FirebaseAuth.instance.currentUser?.photoURL}"),
                    ),
                    accountName: Text("${FirebaseAuth.instance.currentUser?.displayName}"),
                    accountEmail: Text("${FirebaseAuth.instance.currentUser?.email}")),
                ListTile(
                  title: const Text('Cerrar Sesión'),
                  leading: Icon(Icons.exit_to_app, color: SettingsColor.textColor),
                  onTap: () async { 
                    if(FirebaseAuth.instance.currentUser?.providerData[0].providerId == "google.com") { await AuthenticatorGoogle.closeSession(); } 
                    else if(FirebaseAuth.instance.currentUser?.providerData[0].providerId == "facebook.com") { await AuthenticatorFacebook.closeSession(); }
                    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                  }
                )
              ]
            )
          )
        )
      )
    );
  }
}