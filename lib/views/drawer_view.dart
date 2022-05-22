import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natural_20/Auth/AuthenticatorFacebook.dart';
import 'package:natural_20/Auth/AuthenticatorGoogle.dart';
import 'package:natural_20/screens/login_screen.dart';
import 'package:natural_20/settings/settings_color.dart';
import 'package:natural_20/routes/routes.dart';

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
              onTap: () async {
                if (FirebaseAuth
                        .instance.currentUser?.providerData[0].providerId ==
                    "google.com") {
                  await AuthenticatorGoogle.closeSession();
                } else if (FirebaseAuth
                        .instance.currentUser?.providerData[0].providerId ==
                    "facebook.com") {
                  await AuthenticatorFacebook.closeSession();
                }
                Navigator.pushAndRemoveUntil(context, 
                MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
              })
        ])));
  }
}
