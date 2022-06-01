import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natural_20/Auth/AuthenticatorFacebook.dart';
import 'package:natural_20/Auth/AuthenticatorGoogle.dart';
import 'package:natural_20/Auth/AuthenticatorTwittter.dart';
import 'package:natural_20/screens/loading_screen.dart';
import 'package:natural_20/screens/login_screen.dart';
import 'package:natural_20/settings/settings_color.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.6,
        child: Drawer(
            child: ListView(children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: SettingsColor.secondaryColor,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "${FirebaseAuth.instance.currentUser?.photoURL}"),
              ),
              accountName:
                  Text("${FirebaseAuth.instance.currentUser?.displayName}"),
              accountEmail:
                  Text("${FirebaseAuth.instance.currentUser?.email}")),
          ListTile(
              title: const Text('Cerrar Sesión'),
              leading: Icon(Icons.exit_to_app, color: SettingsColor.textColor),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoadingScreen()),
                    (route) => false);
              })
        ])));
  }
}
