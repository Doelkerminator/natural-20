import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:natural_20/Auth/AuthenticatorFacebook.dart';
import 'package:natural_20/Auth/AuthenticatorGoogle.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;
    Divider _divider = const Divider(height: 10);
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Natural 20")
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Image.asset("assets/logo.png", width: screenSizes.width / 1.5),
              GoogleAuthButton(
                onPressed: () async {
                  User? user = await AuthenticatorGoogle.initSession(
                    context: context
                  );
                  print(user?.displayName);
                  Navigator.of(context).pushNamedAndRemoveUntil('/menu', (route) => false);
                },
                darkMode: true,
                style: const AuthButtonStyle(
                  buttonType: null,
                  iconType: null,
                ),
              ),  
              _divider,
              FacebookAuthButton(
                onPressed: () async {
                  User? user = await AuthenticatorFacebook.initSession(
                    context: context
                  );
                  print(user?.displayName);
                  Navigator.of(context).pushNamedAndRemoveUntil('/menu', (route) => false);
                },
                darkMode: true,
                style: const AuthButtonStyle(
                  buttonType: null,
                  iconType: null,
                ),
              ),
              _divider,
              TwitterAuthButton(
                onPressed: () {},
                darkMode: true,
                style: const AuthButtonStyle(
                  buttonType: null,
                  iconType: null,
                ),
              ),
              _divider
            ]
          )
        )
      )
    );
  }
}

