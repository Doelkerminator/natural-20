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
              gAuthButton(),  
              _divider,
              fAuthButton(),
              _divider,
              tAuthButton(),
              _divider
            ]
          )
        )
      )
    );
  }

  Widget gAuthButton(){
    return GoogleAuthButton(
      onPressed: () async {
        await AuthenticatorGoogle.initSession(context: context);
        Navigator.of(context).pushNamedAndRemoveUntil('/menu', (route) => false);
      },
      darkMode: true,
      style: const AuthButtonStyle(
        buttonType: null,
        iconType: null,
      ),
    );
  }

  Widget fAuthButton(){
    return FacebookAuthButton(
      onPressed: () async {
        await AuthenticatorFacebook.initSession(context: context);
        Navigator.of(context).pushNamedAndRemoveUntil('/menu', (route) => false);
      },
      darkMode: true,
      style: const AuthButtonStyle(
        buttonType: null,
        iconType: null,
      )
    );
  }

  Widget tAuthButton(){
    return TwitterAuthButton(
      onPressed: () {},
      darkMode: true,
      style: const AuthButtonStyle(
        buttonType: null,
        iconType: null,
      )
    );
  }
}

